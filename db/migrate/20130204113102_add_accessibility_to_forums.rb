class AddAccessibilityToForums < ActiveRecord::Migration
  def change
    add_column :forums, :accessibility, :string, :default => "open"

    
    Forum.create(:title => "News and Announcements", :description => "Information from the Petyard team.", :position => 1, :forum_category_id => 1, :permalink => "news-and-announcements", :accessibility => "reply-only")
    Forum.create(:title => "Staff Only", :description => "Discussion for Petyard staff (invisible to members).", :position => 2, :forum_category_id => 1, :permalink => "staff-only", :accessibility => "staff-only")
    Forum.create(:title => "Minecraft", :description => "General Minecraft discussion.", :position => 1, :forum_category_id => 2, :permalink => "minecraft")
    Forum.create(:title => "Petyard Server", :description => "Discussion of our Minecraft server.", :position => 2, :forum_category_id => 2, :permalink => "petyard-server")
    Forum.create(:title => "Petyard Website", :description => "Talk about our website, petyard.net.", :position => 3, :forum_category_id => 2, :permalink => "petyard-website")
    Forum.create(:title => "The Lounge", :description => "Anything goes!", :position => 1, :forum_category_id => 3, :permalink => "the-lounge")
  end
end
