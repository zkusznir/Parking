require 'test_helper'

class CarTest < ActiveSupport::TestCase
  
  def setup
    @bmw = cars(:bmw)
  end

  test 'is car valid' do
    assert @bmw.valid?
    assert @bmw.errors.empty?
  end

  test 'is car without registration number not valid' do
    @bmw.registration_number = nil
    assert_not @bmw.valid?
    assert_not @bmw.errors[:registration_number].empty?
  end

  test 'is car without model not valid' do
    @bmw.model = nil
    assert_not @bmw.valid?
    assert_not @bmw.errors[:model].empty?
  end

  test 'is car without owner not valid' do
    @bmw.owner = nil
    assert_not @bmw.valid?
    assert_not @bmw.errors[:owner].empty?
  end
end
