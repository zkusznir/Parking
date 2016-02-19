class Parking < ActiveRecord::Base

  KINDS = [
    'indoor',
    'outdoor',
    'private',
    'street'
  ]

  belongs_to :address
  belongs_to :owner, class_name: 'Person'
  has_many :place_rents

  validates :places, presence: true
  validates :hour_price, :day_price, :places, presence: true, numericality: { greater_than: 0 }
  validates :kind, inclusion: { in: KINDS }

  accepts_nested_attributes_for :address

  before_destroy :shorten_place_rents

  scope :private_parkings, -> { where(kind: 'private') }
  scope :public_parkings, -> { where.not(kind: 'private') }
  scope :day_price_in_range, ->(from, to) { where("day_price between ? and ?", (from || 0), (to || Float::MAX)) }
  scope :hour_price_in_range, ->(from, to) { where("hour_price between ? and ?", (from || 0), (to || Float::MAX)) }
  scope :in_city, ->(city) { joins(:address).where("city = ?", city) }

  def self.search(params)
    parkings = Parking.all
    parkings = parkings.in_city(params[:city]) if params[:city].present?
    parkings = parkings.day_price_in_range(params[:day_price_from].presence, params[:day_price_to].presence)
    parkings = parkings.hour_price_in_range(params[:hour_price_from].presence, params[:hour_price_to].presence)
    unless params[:private_kind] == '1' && params[:public_kind] == '1'
      parkings = parkings.private_parkings if (params[:private_kind] == '1')
      parkings = parkings.public_parkings if (params[:public_kind] == '1')
    end
    parkings
  end

  private

  def shorten_place_rents
    place_rents.exceeding_end_date.each(&:set_date)
  end
end
