class UserMailer < ApplicationMailer
  def otp_email(user, email, otp)
    @user = user
    @otp = otp
    mail(to: email, subject: 'Your OTP Code')
  end
  def borrow_request_notification(user, borrowing)
    @user = user
    @borrowing = borrowing
    @book = borrowing.book
    mail(to: User.where(role: 'library_admin').pluck(:email), subject: 'New Book Borrow Request')
  end
  def return_reminder(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: 'Book Return Reminder')
  end
  def overdue_notification(user, book)
    @user = user
    @book = book
    mail(to: User.where(role: 'library_admin').pluck(:email), subject: 'Overdue Book Notification')
  end
end
