class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    borrowings = Borrowing.where("return_date = ?", Date.tomorrow)

    borrowings.each do |borrowing|
      NotificationJob.perform_later(borrowing.id, 'reminder')
    end
  end
end
