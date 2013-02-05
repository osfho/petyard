class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :tweet_id
      t.string :screen_name
      t.text :content

      t.timestamps
    end
  end
end
