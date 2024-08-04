class CreateTokenBlacklists < ActiveRecord::Migration[7.1]
  def change
    create_table :token_blacklists do |t|
      t.string :jti
      t.datetime :exp
      t.timestamps
    end
    add_index :token_blacklists, :jti
  end
end
