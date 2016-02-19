ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  def set_valid_mock
    OmniAuth.config.test_mode = true
    omniauth_hash = { 'provider' => 'facebook',
                      'uid' => '12345',
                      'info' => {
                          'first_name' => 'Ewa',
                          'last_name' => 'Kusznir',
                          'email' => 'ewa@mail.com'
                      }
    }
    OmniAuth.config.add_mock(:facebook, omniauth_hash)
  end

  def set_invalid_mock
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end

  def silence_omniauth
    previous_logger = OmniAuth.config.logger
    OmniAuth.config.logger = Logger.new("/dev/null")
    yield
  ensure
    OmniAuth.config.logger = previous_logger
  end
  
  def setup
    Capybara.reset!
  end

  def login(email = 'steve@gmail.com', password = 'secret123')
    visit 'login'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Log in'
  end
end

class UserSignedInIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    super
    login
  end
end
