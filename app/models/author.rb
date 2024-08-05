class Author < ApplicationRecord
  has_many :books
  validates :name, presence: true
  validates :date_of_birth, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id",  "name"]
  end
end
