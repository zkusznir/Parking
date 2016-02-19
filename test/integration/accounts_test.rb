require 'test_helper'

class AccountsTest < ActionDispatch::IntegrationTest

  test 'creates a new account' do
    visit '/accounts/new'
    fill_in 'account_email', with: 'ewa@mail.com'
    fill_in 'account_person_attributes_first_name', with: 'Ewa'
    fill_in 'account_person_attributes_last_name', with: 'Kusznir'
    fill_in 'account_password', with: 'secret123'
    fill_in 'account_password_confirmation', with: 'secret123'
    click_button 'Create Account'
    mail = ActionMailer::Base.deliveries.last
    assert_equal 'Welcome to Bookparking', mail.subject
    assert_equal ['ewa@mail.com'], mail.to
    assert_equal ['hello@bookparking.dev'], mail.from
    assert_match 'Hello, Ewa', mail.body.encoded
    assert_match login_url, mail.body.encoded
    assert_equal root_path, current_path
    assert has_content? 'successfully created'
  end

  test 'does not create an account when passwords don't match' do
    visit '/accounts/new'
    fill_in 'account_email', with: 'ewa@mail.com'
    fill_in 'account_person_attributes_first_name', with: 'Ewa'
    fill_in 'account_password', with: 'secret123'
    fill_in 'account_password_confirmation', with: 'fail'
    click_button 'Create Account'
    assert has_content? 'doesn\'t match'
  end

  test 'does not create an account without name' do
    visit '/accounts/new'
    fill_in 'account_email', with: 'ewa@mail.com'
    fill_in 'account_password', with: 'secret123'
    fill_in 'account_password_confirmation', with: 'secret123'
    click_button 'Create Account'
    assert has_content? 'first name can\'t be blank'
  end

  test 'does not create an account when email already taken' do
    visit '/accounts/new'
    fill_in 'account_email', with: 'steve@gmail.com'
    fill_in 'account_person_attributes_first_name', with: 'Ewa'
    fill_in 'account_password', with: 'secret123'
    fill_in 'account_password_confirmation', with: 'fail'
    click_button 'Create Account'
    assert has_content? 'already been taken'
  end

  test 'does not create an account when user logged in' do
    visit 'login'
    fill_in 'email', with: 'steve@gmail.com'
    fill_in 'password', with: 'secret123'
    click_button 'Log in'
    visit 'accounts/new'
    assert_equal root_path, current_path
  end
end
