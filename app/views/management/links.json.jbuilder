
payload = @result_service.payload

if payload.present?
  json.data payload.links do |link|
    json.origin_url link.origin 
    json.shorten_url shorten_url link
  end
  json.page params[:page].to_i
  json.total_pages payload.total_pages 
  json.total_items payload.total_items
end