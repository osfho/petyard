class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.boolean :locked
      t.boolean :sticky
      t.integer :user_id
      t.integer :forum_id
      t.string :permalink

      t.timestamps
    end
  end
end
