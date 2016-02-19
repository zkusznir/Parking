require 'test_helper'

class FacebookAccountsTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  test 'user signs in with valid credentials' do
    set_valid_mock
    visit login_fb_path
    assert has_content? 'successfully'
    assert has_content? 'Ewa'
  end

  test 'user signs in with invalid credentials' do
    silence_omniauth do
      set_invalid_mock
      visit login_fb_path
      assert has_content? 'failure'
      assert_not has_content? 'Log out' 
    end
  end
end
