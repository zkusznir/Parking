require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest

  def setup
    visit '/'
    @parking = parkings(:renoma)
  end

  test 'user opens parkings index' do
    visit parkings_path
    assert has_content? 'Parking'
  end

  test 'user opens parking details' do
    visit 'parkings/#{@parking.id}'
    assert has_content? 'Private'
    assert has_content? 3.0
    assert has_content? 25.0
    assert has_content? 'Wroclaw'
    assert has_content? 'Swidnicka'
  end

  test 'user adds new parking' do
    visit 'parkings/new'
    fill_in 'parking_places', with: '10'
    fill_in 'parking_hour_price', with: '2'
    fill_in 'parking_day_price', with: '3'
    fill_in 'parking_address_attributes_city', with: 'Katowice'
    fill_in 'parking_address_attributes_street', with: 'Czarna'
    fill_in 'parking_address_attributes_zip_code', with: '52-230'
    click_button 'Save'
    assert has_content? 'successfully'
    assert has_content? '10'
    assert has_content? '2'
    assert has_content? '3'
    assert has_content? 'Katowice'
    assert has_content? 'Czarna'
  end

  test 'user edits a parking' do
    visit 'parkings/#{@parking.id}/edit'
    fill_in 'parking_places', with: '12345'
    fill_in 'parking_hour_price', with: '5'
    fill_in 'parking_day_price', with: '30'
    fill_in 'parking_address_attributes_city', with: 'Jelenia Gora'
    fill_in 'parking_address_attributes_street', with: 'Sezamkowa'
    fill_in 'parking_address_attributes_zip_code', with: '22-222'
    click_button 'Save'
    assert has_content? 'successfully'
    assert has_content? '12345'
    assert has_content? '5'
    assert has_content? '30'
    assert has_content? 'Jelenia Gora'
    assert has_content? 'Sezamkowa'
  end

  test 'user removes a parking' do
    visit parkings_path
    find('tr', text: 'Wroclaw').click_link 'Delete'
    assert_not has_content? 'Wroclaw'
  end

  test 'user searches for any parking' do
    visit parkings_path
    click_button 'Search'
    assert has_content? 'Wroclaw'
    assert has_content? 'Warszawa'
  end

  test 'user searches for parking that does not exist' do
    visit parkings_path
    fill_in 'day_price_from', with: '70'
    fill_in 'day_price_to', with: '80'
    click_button 'Search'
    assert_not has_content? 'Wroclaw'
    assert_not has_content? 'Warszawa'
  end

  test 'user searches for private parkings' do
    visit parkings_path
    check 'private_kind'
    click_button 'Search'
    assert has_content? 'Wroclaw'
    assert_not has_content? 'Warszawa'
  end

  test 'user searches for parking in given price range' do
    visit parkings_path
    fill_in 'day_price_from', with: '10'
    fill_in 'day_price_to', with: '20'
    click_button 'Search'
    assert_not has_content? 'Wroclaw'
    assert has_content? 'Warszawa'
  end

  test 'user searches a parking' do
    visit parkings_path
    check 'private_kind'
    fill_in 'day_price_from', with: '20'
    fill_in 'day_price_to', with: '30'
    fill_in 'hour_price_from', with: '1'
    fill_in 'hour_price_to', with: '5'
    fill_in 'city', with: 'Wroclaw'
    assert find_field('private_kind').checked?
    assert_equal '20', find_field('day_price_from').value
    assert_equal '30', find_field('day_price_to').value
    assert_equal '1', find_field('hour_price_from').value
    assert_equal '5', find_field('hour_price_to').value
    assert_equal 'Wroclaw', find_field('city').value
  end
end
