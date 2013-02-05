class CreateForumCategories < ActiveRecord::Migration
  def change
    create_table :forum_categories do |t|
      t.string :title
      t.integer :position, :default => 1

      t.timestamps
    end

    ForumCategory.create(:title => 'Official')
    ForumCategory.create(:title => 'General', :position => 2)
    ForumCategory.create(:title => 'Off Topic', :position => 3)
  end
end
