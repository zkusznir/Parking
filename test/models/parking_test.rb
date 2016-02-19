require 'test_helper'

class ParkingTest < ActiveSupport::TestCase

  def setup
    @parking = parkings(:renoma)
  end

  test 'is parking valid' do
    assert @parking.valid?
    assert @parking.errors.empty?
  end

  test 'is parking without places not valid' do
    @parking.places = nil
    assert_not @parking.valid?
    assert_not @parking.errors[:places].empty?
  end

  test 'is parking without kind not valid' do
    @parking.kind = nil
    assert_not @parking.valid?
    assert_not @parking.errors[:kind].empty?
  end

  test 'is parking without hour price not valid' do
    @parking.hour_price = nil
    assert_not @parking.valid?
    assert_not @parking.errors[:hour_price].empty?
  end

  test 'is parking without day price not valid' do
    @parking.day_price = nil
    assert_not @parking.valid?
    assert_not @parking.errors[:day_price].empty?
  end

  test 'is parking with invalid kind not valid' do
    @parking.kind = 'not a kind'
    assert_not @parking.valid?
    assert_not @parking.errors[:kind].empty?
  end

  test 'is parking with invalid places not valid' do
    @parking.places = -5
    assert_not @parking.valid?
    assert_not @parking.errors[:places].empty?
  end

  test 'is parking with invalid hour_price not valid' do
    @parking.hour_price = -5
    assert_not @parking.valid?
    assert_not @parking.errors[:hour_price].empty?
  end

  test 'is parking with invalid day_price not valid' do
    @parking.day_price = -5
    assert_not @parking.valid?
    assert_not @parking.errors[:day_price].empty?
  end

  test 'does shorten places rents' do
    rent = @parking.place_rents.first
    rent.end_date = 3.days.from_now
    rent.save
    @parking.destroy
    assert_equal Time.now.utc.to_s, rent.reload.end_date.to_s
  end

  test 'selects private parkings' do
    parkings = Parking.private_parkings
    assert_equal 1, parkings.size
    assert_equal 'private', parkings[0].kind
  end

  test 'selects public parkings' do
    parkings = Parking.public_parkings
    assert_equal 1, parkings.size
    assert_not_equal 'private', parkings[0].kind
  end

  test 'selects parkings with day_price in given range' do
    parkings = Parking.day_price_in_range(20, 30)
    assert_equal 1, parkings.size
    assert_equal 600, parkings[0].places
  end

  test 'selects parkings with hour_price in given range' do
    parkings = Parking.hour_price_in_range(2.5, 3)
    assert_equal 1, parkings.size
    assert_equal 600, parkings[0].places
  end

  test 'selects parkings from given city' do
    parkings = Parking.in_city('Wroclaw')
    assert_equal 1, parkings.size
    assert_equal 'Wroclaw', parkings[0].address.city
  end
end
