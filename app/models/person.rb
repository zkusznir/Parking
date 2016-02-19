class Person < ActiveRecord::Base
  has_many :parkings, dependent: :destroy, foreign_key: 'owner_id'
  has_many :cars, dependent: :destroy, foreign_key: 'owner_id'
  has_one :account
  has_one :facebook_account

  validates :first_name, presence: true

  def full_name
    "#{first_name} #{last_name || ""}"
  end
end
