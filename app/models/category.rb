class Category < ApplicationRecord
  has_and_belongs_to_many :books
  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end
end
