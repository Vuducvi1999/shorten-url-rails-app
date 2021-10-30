
# input: page
# output: all links if valid access key
#         'welcome' string at home page


class Management::ListLinksService < BaseService
  def initialize page:0, user:nil
    @page = page 
    @user = user
  end

  def call
    return ResultService.new status: :unauthorized unless @user 
    ResultService.new payload: content_payload.new(
      all_links, 
      total_items, 
      total_pages
    ), status: :ok
  end

  private

  def all_links
    @user.shorten_urls.page(@page)
  end

  def total_items
    @total_items ||= @user.shorten_urls.size
  end

  def total_pages 
    is_remaining = total_items % Kaminari.config.default_per_page != 0
    division = total_items / Kaminari.config.default_per_page
    is_remaining ? (division + 1) : division
  end

  def content_payload
    Struct.new(:links, :total_items, :total_pages)
  end
end