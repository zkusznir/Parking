class AccountsController < ApplicationController
  skip_before_filter :logged_in
  before_filter :anyone_logged_in?

  def new
    @account = Account.new
    @account.build_person
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      AccountMailer.welcome_mail(@account).deliver
      redirect_to root_path, notice: 'Account successfully created!'
    else
      render action: 'new'
    end
  end

  private

  def anyone_logged_in?
    redirect_to root_path if current_person
  end

  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation,
                                    person_attributes: [:first_name, :last_name])
  end
end
