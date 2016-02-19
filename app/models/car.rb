class Car < ActiveRecord::Base
  extend Dragonfly::Model

	belongs_to :owner, class_name: 'Person'
  has_many :place_rents, dependent: :destroy

  validates :model, :registration_number, :owner, presence: true
  validates_size_of :image, :maximum => 200.kilobytes,
                    :message => "must have size up to 200kB"
  validates_property :format, of: :image, in: ['jpg', 'jpeg', 'png', 'gif'],
                     :message => "must have format .jpg, .jpeg, .png or .gif"

  dragonfly_accessor :image do
    storage_options do |attachment|
      {
        path: "images/#{rand(100)}",
        headers: {"x-amz-acl" => "public-read-write"}
      }
    end
  end


  def to_param
    "#{id}-#{model.parameterize}"
  end
end
