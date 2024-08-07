class NotificationJob < ApplicationJob
  queue_as :default

  def perform(borrowing_id, type)
    borrowing = Borrowing.find(borrowing_id)

    case type
    when 'reminder'
      UserMailer.return_reminder(borrowing.user, borrowing.book).deliver_now
    when 'overdue'
      UserMailer.overdue_notification(borrowing.user, borrowing.book).deliver_now
    end
  end
end
