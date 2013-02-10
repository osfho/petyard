class MakeStickyDefaultfalseInTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :sticky
    add_column :topics, :sticky, :boolean, :default => false
  end
end
