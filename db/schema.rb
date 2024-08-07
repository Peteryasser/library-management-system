# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_07_090617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.bigint "author_id", null: false
    t.bigint "shelf_id", null: false
    t.float "rating", default: 0.0
    t.integer "review_count", default: 0
    t.integer "stock", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["shelf_id"], name: "index_books_on_shelf_id"
  end

  create_table "books_categories", id: false, force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "category_id", null: false
    t.index ["book_id", "category_id"], name: "index_books_categories_on_book_id_and_category_id", unique: true
    t.index ["category_id", "book_id"], name: "index_books_categories_on_category_id_and_book_id"
  end

  create_table "borrowings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "book_id", null: false
    t.integer "status"
    t.date "approved_date"
    t.date "return_date"
    t.integer "number_of_days"
    t.boolean "is_returned_on_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "approved_by_id"
    t.index ["approved_by_id"], name: "index_borrowings_on_approved_by_id"
    t.index ["book_id"], name: "index_borrowings_on_book_id"
    t.index ["user_id"], name: "index_borrowings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "shelves", force: :cascade do |t|
    t.integer "capacity"
    t.string "code"
    t.integer "number_of_books"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "token_blacklists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_token_blacklists_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "user_name"
    t.integer "status"
    t.integer "role"
    t.string "otp"
    t.datetime "otp_expiry"
    t.boolean "otp_verified", default: false
    t.boolean "can_borrow"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "books", "authors"
  add_foreign_key "books", "shelves"
  add_foreign_key "borrowings", "books"
  add_foreign_key "borrowings", "users"
  add_foreign_key "borrowings", "users", column: "approved_by_id"
end
