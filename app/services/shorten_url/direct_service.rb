
# input: shorten_url url
# output: ShortenUrl record created if success
#         errors messages if fail

class ShortenUrl::DirectService < BaseService
  include Rails.application.routes.url_helpers
  include Entityable

  def initialize shorten_url:''
    @shorten_url = shorten_url
  end

  def call
    return ResultService.new errors:errors, status: :unprocessable_entity if record.nil?
    ResultService.new payload:record_incremented
  end

  private

  def alias_path
    @shorten_url.gsub root_url,''
  end

  def record 
    @record ||= ShortenUrl.find_by alias:alias_path
  end

  def record_incremented
    @record.try :increment!, :clicked
  end
end