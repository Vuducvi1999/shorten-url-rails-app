
# input: user, origin url
# output: ShortenUrl record created if success
#         errors messages if fail
#         errors: {user: ['missing user'], origin: ['invalid url'], ...}

class ShortenUrl::CompressService < BaseService
  def initialize user: nil, origin:''
    @origin = origin 
    @user = user
  end

  def call
    errors_messages = shorten_url.errors.messages
    return ResultService.new errors: errors_messages if errors_messages.any?
    ResultService.new payload: shorten_url, status: :created
  end

  private

  def shorten_url
    @url ||= ShortenUrl.create origin:@origin, user:@user
  end  
end