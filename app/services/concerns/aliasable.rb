module Aliasable
  def record 
    @record ||= ShortenUrl.find_by alias: @alias
  end
end