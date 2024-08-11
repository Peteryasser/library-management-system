class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :approved_by, class_name: 'User', optional: true

  enum status: { pending: 0, approved: 1, rejected: 2, returned: 3 }
  validates :number_of_days, presence: true

  before_create :decrement_book_stock
  after_update :increment_book_stock


  def decrement_book_stock
    raise 'This Book is not found. Choose another one or wait for other borrowers to return it' if book.stock <= 0
    Book.transaction do
      book.lock!
      book.decrement!(:stock)
    end
  end 

  def increment_book_stock
    if self.status == 'returned' || self.status == 'rejected'
    Book.transaction do
      book.lock!
      book.increment!(:stock)
    end
  end 


end
