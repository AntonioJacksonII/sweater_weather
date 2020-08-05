class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :api_key, uniqueness: true, presence: true
  has_secure_password

  def self.valid_api_key?(api_key)
    find_by(api_key: api_key)
  end
end
