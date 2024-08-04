class UserMailer < ApplicationMailer
  def otp_email(user, email, otp)
    @user = user
    @otp = otp
    mail(to: email, subject: 'Your OTP Code')
  end
end
