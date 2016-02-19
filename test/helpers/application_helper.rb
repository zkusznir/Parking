require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  def controller_name
    'place_rents'
  end

  test 'is page title valid' do
    assert_equal 'Place rents', page_title
  end
end
