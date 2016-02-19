require 'test_helper'

class SessionTest < ActionDispatch::IntegrationTest

  test 'current user displayed when logged in from main page' do
    login
    assert current_path == '/'
    assert has_content? 'Steve'
  end

  test 'user attempts to log in from any page' do
    visit '/cars'
    click_link 'Log in'
    fill_in 'email', with: 'steve@gmail.com'
    fill_in 'password', with: 'secret123'
    click_button 'Log in'
    assert current_path == '/cars'
  end

  test 'user redirected to log in page when login failed' do
    login('steve@gmail.com', 'fail')
    assert current_path =~ /login/
    assert has_content? 'Wrong'
  end

  test 'current user not displayed when no user logged in' do
    visit '/'
    assert has_content? 'Log in'
    assert_not has_content? 'Steve'
  end
end
