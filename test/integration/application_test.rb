require 'test_helper'

class ApplicationTest < ActionDispatch::IntegrationTest

  test 'language switches from english to polish' do
    visit 'en/parkings'
    assert has_content? 'Parkings'
    click_link 'Polski'
    assert has_content? 'Parkingi'
  end

  test 'language switches from polish to english' do
    visit 'pl/parkings'
    assert has_content? 'Parkingi'
    click_link 'English'
    assert has_content? 'Parkings'
  end

  test 'default languge is english' do
    visit '/'
    assert has_content? 'Parkings'
  end
end
