class User < ApplicationRecord
  has_secure_password

  has_many :shorten_urls, dependent: :destroy

  validates :name, :email, :password, presence: true
  validates :access_api, uniqueness: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create do |user|
    user.access_api = SecureRandom.base58(8)
  end
end
