class User < ApplicationRecord
  has_many :posts
  attr_accessor :password

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, :password_digest, presence: true
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end
