class Shelf < ApplicationRecord
  has_many :books
  validates :code, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :number_of_books, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :capacity, on: :update} 

  validate :prevent_number_of_books_update, on: :update

  def prevent_number_of_books_update
    if self.number_of_books_changed?
      self.errors.add(:base, 'Cannot change the number_of_books directly')
    end
  end
end
