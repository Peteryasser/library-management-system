class CreateShelves < ActiveRecord::Migration[7.1]
  def change
    create_table :shelves do |t|
      t.integer :capacity
      t.string :code
      t.integer :number_of_books

      t.timestamps
    end
  end
end
