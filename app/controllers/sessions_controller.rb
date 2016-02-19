class SessionsController < ApplicationController
  skip_before_action :logged_in

  def create
    if request.env['omniauth.auth']
      account = FacebookAccount.find_or_create_for_facebook(request.env['omniauth.auth'])
      redirect_to root_path, notice: 'You have successfully logged in!'
      session[:id] = account.id
      session[:type] = 'facebook'
    else
      binding.pry
      if account = Account.authenticate(params[:email], params[:password])
        session[:id] = account.id
        session[:type] = 'normal'
        back
      else
        redirect_to login_path, alert: 'Wrong credentials!'
      end
    end
    current_person
  end

  def destroy
    session[:id] = nil
    session[:type] = nil
    redirect_to root_path, notice: 'You have successfully logged out!'
  end

  def failure
    redirect_to root_url, alert: 'Log in failure!'
  end

  private

  def back(default = root_path)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
end
