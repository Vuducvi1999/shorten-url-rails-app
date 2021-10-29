
# input: access_key
# output: all links if valid access key
#         'welcome' string at home page


class HomePage::ListLinksService < BaseService
  def initialize access_key:''
    @access_key = access_key 
  end

  def call
    return ResultService.new unless user 
    ResultService.new payload: all_links 
  end

  private

  def user 
    @user ||= User.includes(:shorten_urls).find_by access_key: @access_key 
  end

  def all_links
    @user.shorten_urls
  end
end