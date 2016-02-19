require 'test_helper'

class CarsTest < UserSignedInIntegrationTest

  def setup
    super
    @car = cars(:bmw)
    person = people(:steve)
  end

  test 'user opens cars index' do
    visit cars_path
    assert has_content? 'Car'
  end

  test 'user opens car details' do
    visit car_path(@car)
    assert has_content? @car.registration_number
    assert has_content? @car.model
  end

  test 'user adds new car' do
    visit new_car_path
    fill_in 'car_registration_number', with: 'DW 11111'
    fill_in 'car_model', with: 'Audi'
    click_button 'Create Car'
    assert has_content? 'successfully'
    assert has_content? 'DW 11111'
    assert has_content? 'Audi'
  end

  test 'user edits a car' do
    visit edit_car_path(@car)
    fill_in 'car_registration_number', with: 'DW 11111'
    fill_in 'car_model', with: 'Audi'
    click_button 'Update Car'
    assert has_content? 'successfully'
    assert has_content? 'DW 11111'
    assert has_content? 'Audi'
  end

  test 'user removes a car' do
    visit cars_path
    click_link 'Delete'
    assert_not has_content? 'DW 11111'
  end

  test 'user uploads an image of proper size' do
    visit edit_car_path(@car)
    attach_file('car_image', File.join(Rails.root, '/test/fixtures/audi_small.jpg'))
    click_button 'Update Car'
    assert has_content? 'successfully updated'
    assert has_content? 'Image:'
  end

  test 'user uploads too big image' do
    visit edit_car_path(@car)
    attach_file('car_image', File.join(Rails.root, '/test/fixtures/audi_big.jpeg'))
    click_button 'Update Car'
    assert has_content? 'Save failed'
  end

  test 'user removes an image' do
    visit edit_car_path(@car)
    attach_file('car_image', File.join(Rails.root, '/test/fixtures/audi_small.jpg'))
    click_button 'Update Car'
    visit edit_car_path(@car)
    check 'car_remove_image'
    click_button 'Update Car'
    visit car_path(@car)
    assert_not has_content? 'Image'
  end
end
