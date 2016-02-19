require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  
  def setup
    @person = people(:steve)
  end

  test 'is person valid' do
    assert @person.valid?
    assert @person.errors.empty?
  end

  test 'is person without first name not valid' do
    @person.first_name = nil
    assert_not @person.valid?
    assert_not @person.errors[:first_name].empty?
  end
end
