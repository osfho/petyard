class AddAttachmentIconToRanks < ActiveRecord::Migration
  def self.up
    change_table :ranks do |t|
      t.attachment :icon
    end
  end

  def self.down
    drop_attached_file :ranks, :icon
  end
end
