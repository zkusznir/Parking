class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking

  validates :start_date, :end_date, :parking, :car, presence: true
  validate :start_date_is_less_than_end_date

  before_save :calculate_price
  before_save :set_identifier

  scope :exceeding_end_date, -> { where("end_date > ?", Time.now) }

  def set_date
    update(end_date: Time.now)
  end

  def to_param
    identifier
  end

  def self.find_by_id_or_identifier(input)
    find(input)
  rescue
    find_by!(identifier: input)
  end

  private

  def start_date_is_less_than_end_date
    errors.add(:start_date) if start_date && end_date && start_date > end_date
  end

  def set_identifier
    self.identifier = SecureRandom.uuid
  end

  def calculate_price
    duration = (end_date.to_time - start_date.to_time) / 1.hour
    self.price = parking.day_price * days(duration) + parking.hour_price * hours(duration)
  end

  def days(duration)
    (duration / 24).to_i
  end

  def hours(duration)
    (duration % 24).ceil
  end
end
