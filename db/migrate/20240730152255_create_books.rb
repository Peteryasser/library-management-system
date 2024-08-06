class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.references :author, null: false, foreign_key: true
      t.references :shelf, null: false, foreign_key: true
      t.float :rating, default: 0.0 
      t.integer :review_count, default: 0
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
