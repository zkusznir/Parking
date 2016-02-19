require 'test_helper'

class PlaceRentsTest < UserSignedInIntegrationTest

  def setup
    super
    @parking = parkings(:renoma)
  end

  test 'user rents a place' do
    visit 'en/parkings/#{@parking.id}/place_rents/new'
    fill_in 'place_rent_start_date', with: '08-11-2014 12:30:00'
    fill_in 'place_rent_end_date', with: '10-11-2014 12:30:00'
    select 'BMW 535i', from: 'place_rent_car_id'
    click_button 'Create Place rent'
    assert has_content? 'successfully'
    assert has_content? '2014-11-08 12:30:00'
    assert has_content? '2014-11-10 12:30:00'
    assert has_content? 'DW 12345'
  end
end
