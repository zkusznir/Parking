class AccountMailer < ActionMailer::Base
  default from: 'hello@bookparking.dev'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.welcome_mail.subject
  #
  def welcome_mail(account)
    @account = account
    mail to: @account.email, subject: 'Welcome to Bookparking'
  end
end
