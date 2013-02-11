class MakeStickyDefaultfalseInTopics < ActiveRecord::Migration
  def change
    add_column :topics, :sticky, :boolean, { :default => false, :null => false }
  end
end
