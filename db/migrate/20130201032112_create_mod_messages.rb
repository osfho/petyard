class CreateModMessages < ActiveRecord::Migration
  def change
    create_table :mod_messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
