class Shelf < ApplicationRecord

  validates :code, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :number_of_books, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :capacity}

  before_update :prevent_number_of_books_update

  def prevent_number_of_books_update
    if self.number_of_books_changed?
      self.errors.add('Cannot change the number_of_books directly')
    end
  end
end
