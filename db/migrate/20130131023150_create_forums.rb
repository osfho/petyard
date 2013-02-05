class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.string :description
      t.integer :position, :default => 1
      t.integer :forum_category_id, :default => 1
      t.string :permalink

      t.timestamps
    end
  end
end
