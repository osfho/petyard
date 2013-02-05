class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
