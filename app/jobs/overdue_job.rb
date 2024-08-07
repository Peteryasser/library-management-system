class OverdueJob < ApplicationJob
  queue_as :default

  def perform
    borrowings = Borrowing.where("return_date < ? AND status != ?", Date.today, 'returned')

    borrowings.each do |borrowing|
      NotificationJob.perform_later(borrowing.id, 'overdue')
      borrowing.update(is_returned_on_time: false)
    end
  end
end
