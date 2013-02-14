class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :permalink
      t.text :description
      t.attachment :feature_image
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :z_coordinate
      t.boolean :visible, :default => true
      t.boolean :invite_only, :default => false
      t.string :status, :default => "active"

      t.timestamps
    end
  end
end
