require 'test_helper'

class AccountMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  def setup
    @account = accounts(:steve_account)
  end

  test 'welcome_mail' do
    mail = AccountMailer.welcome_mail(@account)
    assert_equal 'Welcome to Bookparking', mail.subject
    assert_equal ['steve@gmail.com'], mail.to
    assert_equal ['hello@bookparking.dev'], mail.from
    assert_match 'Hello, Steve', mail.body.encoded
    assert_match login_url, mail.body.encoded
  end
end
