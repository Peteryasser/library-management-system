class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validate :can_review_book?

  after_save :update_book_rating

  private

  def can_review_book?
    unless user.borrowings.where(book_id: book.id, status: 'returned').exists?
      errors.add(:base, 'You can only review a book after returning it.')
    end
  end

  def update_book_rating
    book.update_rating_and_review_count
  end

end