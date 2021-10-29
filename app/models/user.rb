class User < ApplicationRecord
  has_secure_password

  has_many :shorten_urls, dependent: :destroy

  validates :name, :email, :password, :access_key, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_initialize do |user|
    user.access_key = SecureRandom.base58 24
  end
end
