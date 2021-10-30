class ShortenUrl < ApplicationRecord
  belongs_to :user

  validates :alias, uniqueness: true
  validates :origin, url: true, presence: true

  before_create :adjust_attr
  
  private

  def adjust_attr
    self.clicked = 0
    self.alias = SecureRandom.base58 7
    url_parse = URI.parse self.origin
    self.origin = "http://#{self.origin}" unless url_parse.scheme
  end
end
