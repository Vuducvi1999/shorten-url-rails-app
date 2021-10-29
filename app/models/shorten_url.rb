class ShortenUrl < ApplicationRecord
  belongs_to :user

  validates :origin, :link, presence: true
  validates :origin, url: true

  after_initialize {|url| url.clicked = 0 }
end
