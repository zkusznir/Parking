require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  def setup
    @address = addresses(:wroclaw)
  end

  test 'is address valid' do
    assert @address.valid?
    assert @address.errors.empty?
  end

  test 'is address without city not valid' do
    @address.city = nil
    assert_not @address.valid?
    binding.pry
    assert_not @address.errors[:city].empty?
  end

  test 'is address without street not valid' do
    @address.street = nil
    assert_not @address.valid?
    assert_not @address.errors[:street].empty?
  end

  test 'is address without zip code not valid' do
    @address.zip_code = nil
    assert_not @address.valid?
    assert_not @address.errors[:zip_code].empty?
  end

  test 'is address with incorrect zipcode not valid' do
    @address.zip_code = '22222'
    assert_not @address.valid?
    assert_not @address.errors[:zip_code].empty?
  end
end
