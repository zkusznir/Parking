# Preview all emails at http://localhost:3000/rails/mailers/mailer
class MailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mailer/welcome_mail
  def welcome_mail
    Mailer.welcome_mail
  end

end
