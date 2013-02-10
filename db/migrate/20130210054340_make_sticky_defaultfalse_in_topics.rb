class MakeStickyDefaultfalseInTopics < ActiveRecord::Migration
  def change
    add_column :topics, :sticky, :boolean, :default => 0
  end
end
