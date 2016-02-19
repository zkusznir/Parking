require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase

  def setup
    @place_rent = place_rents(:first_rental)
  end

  test 'is place rent valid' do
    assert @place_rent.valid?
    assert @place_rent.errors.empty?
  end

  test 'is place rent without start date not valid' do
    @place_rent.start_date = nil
    assert_not @place_rent.valid?
    assert_not @place_rent.errors[:start_date].empty?
  end

  test 'is place rent without end date not valid' do
    @place_rent.end_date = nil
    assert_not @place_rent.valid?
    assert_not @place_rent.errors[:end_date].empty?
  end

  test 'is place rent without parking not valid' do
    @place_rent.parking = nil
    assert_not @place_rent.valid?
    assert_not @place_rent.errors[:parking].empty?
  end

  test 'is place rent without car not valid' do
    @place_rent.car = nil
    assert_not @place_rent.valid?
    assert_not @place_rent.errors[:car].empty?
  end

  # test for start_date greater than end_date
  test 'is place rent with invalid dates not valid' do
    @place_rent.start_date = '2014-11-11 10:50:00'
    assert_not @place_rent.valid?
    assert_not @place_rent.errors[:start_date].empty?
  end

  test 'is price valid' do
    @place_rent.end_date = '2014-11-10 11:20:00'
    @place_rent.save
    assert_equal 128, @place_rent.price
  end
end
