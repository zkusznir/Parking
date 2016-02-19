class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_person, :logged_in
  before_action :logged_in
  before_action :set_locale

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end
  
  private

  def extract_locale_from_accept_language_header
    locales = I18n.available_locales.map(&:to_s)
    browser_request = request.env['HTTP_ACCEPT_LANGUAGE']
    browser_language = browser_request.scan(/^[a-z]{2}/).first if browser_request
    locales.include?(browser_language) ? browser_language : I18n.default_locale
  end

  def current_person
    if session[:id]
      @current_person ||= Account.find(session[:id]).person if session[:type] == "normal"
      @current_person ||= FacebookAccount.find(session[:id]).person if session[:type] == "facebook"
    end
    @current_person
  end

  def logged_in
    session[:return_to] = request.url if request.get?
    redirect_to login_path, :alert => "Please sign in first!" if current_person.nil?
  end
end
