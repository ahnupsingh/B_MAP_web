class User < ActiveRecord::Base
  before_save {self.email = self.email.downcase}
  validates :name, presence: true, length: { maximum: 50}
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6}
  has_secure_password
end