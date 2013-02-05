class AddLatestPostIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :latest_post_id, :integer
  end
end
