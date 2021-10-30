module ApplicationHelper
  include Rails.application.routes.url_helpers

  def shorten_url data
    root_url + data.alias
  end
end