class FacebookAccount < ActiveRecord::Base
  belongs_to :person

  validates :uid, :person, presence: true

  def self.find_or_create_for_facebook(auth_hash)
    find_or_create_by(uid: auth_hash["uid"]) do |account_facebook|
      account_facebook.build_person(
        first_name: auth_hash["info"]["first_name"],
        last_name: auth_hash["info"]["last_name"]
        )
      account_facebook.person.save
    end
  end
end
