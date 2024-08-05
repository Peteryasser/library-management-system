class Book < ApplicationRecord
  belongs_to :author
  belongs_to :shelf
  has_and_belongs_to_many :categories


  validates :title, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :review_count, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validate :categories_limit
  before_create :increment_shelf_book_count
  after_destroy :decrement_shelf_book_count
  before_update :update_shelf_book_count


  def self.ransackable_attributes(auth_object = nil)
    ["author_id", "created_at", "id", "id_value", "rating", "review_count", "shelf_id", "stock", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["author", "categories", "shelf"]
  end
  
  private

  def categories_limit
    errors.add(:categories, "can't have more than 3 categories") if categories.size > 3
  end

  def increment_shelf_book_count(current_shelf = shelf)
    raise 'This shelf is full. Choose another one' if current_shelf.number_of_books >= shelf.capacity
    Shelf.transaction do
      current_shelf.lock!
      current_shelf.increment!(:number_of_books)
    end
  end

  def decrement_shelf_book_count(current_shelf = shelf)
    raise 'This shelf is empty' if current_shelf.number_of_books <= 0
    Shelf.transaction do
      current_shelf.lock!
      current_shelf.decrement!(:number_of_books)
    end
  end

  def update_shelf_book_count
    if shelf_id_changed?
      old_shelf = Shelf.find_by(id: shelf_id_was)
      new_shelf = Shelf.find_by(id: shelf_id)

      # Decrement the old shelf's number_of_books
      decrement_shelf_book_count(old_shelf) if old_shelf

      # Increment the new shelf's number_of_books
      increment_shelf_book_count(new_shelf) if new_shelf
      self.shelf.reload 
    end
  end
end
