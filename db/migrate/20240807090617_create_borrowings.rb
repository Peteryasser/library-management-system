class CreateBorrowings < ActiveRecord::Migration[7.1]
  def change
    create_table :borrowings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :status
      t.date :approved_date
      t.date :return_date
      t.integer :number_of_days
      t.boolean :is_returned_on_time

      t.timestamps
    end
    add_reference :borrowings, :approved_by, foreign_key: { to_table: :users }
  end
end
