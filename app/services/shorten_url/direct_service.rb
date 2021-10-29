
# input: shorten_url url
# output: ShortenUrl record created if success
#         errors messages if fail

class ShortenUrl::DirectService < BaseService
  include Rails.application.routes.url_helpers

  def initialize shorten_url:''
    @shorten_url = shorten_url
  end

  def call
    return ResultService.new errors:errors, status: :unprocessable_entity if record.nil?
    ResultService.new payload:record, status: :ok
  end

  private

  def alias_path
    @shorten_url.gsub root_url,''
  end

  def record 
    @record ||= ShortenUrl.find_by alias:alias_path
  end

  def errors
    {
      messages:[ 'entity not found' ]
    }
  end
end