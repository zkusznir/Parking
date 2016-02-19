class Account < ActiveRecord::Base
  belongs_to :person
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true

  accepts_nested_attributes_for :person

  attr_accessor :flash_notice

  has_secure_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    user.authenticate(password) if user
  end
end
