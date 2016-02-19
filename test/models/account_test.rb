require 'test_helper'

class AccountTest < ActiveSupport::TestCase
 
  def setup
    @account = accounts(:steve_account)
  end

  test 'are account credentials valid' do
    assert_equal @account, Account.authenticate(@account.email, 'secret123')
  end

  test 'is account with no credentials valid' do
    assert_equal nil, Account.authenticate('', '')
  end

  test 'is account with invalid email valid' do
    assert_equal nil, Account.authenticate('email', 'secret123')
  end
end
