module Urlable
  def url_exist? url_string
    Timeout.timeout 3 do
      url = URI.parse url_string
      new_url = url.scheme || "http://#{url_string}"
      url = URI.parse new_url if url.scheme.nil?
      req = Net::HTTP.new url.host, url.port
      req.use_ssl = url.scheme == 'https'
      path = url.path if url.path.present?
      res = req.request_head(path || '/')
      res.code != "404"
    end
  rescue 
    false
  end
end