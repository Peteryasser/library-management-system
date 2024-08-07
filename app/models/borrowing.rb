class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :approved_by, class_name: 'User', optional: true

  enum status: { pending: 0, approved: 1, rejected: 2, returned: 3 }
  validates :number_of_days, presence: true
end
