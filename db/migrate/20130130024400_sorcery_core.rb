class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,         :null => false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.integer :rank_id,         :default => 2
      t.string :title
      t.attachment :avatar

      t.timestamps
    end

   User.create(:username => 'jdrez', :password => 'jamboree', :password_confirmation => 'jamboree', :rank_id => 17) 
  end

  def self.down
    drop_table :users
  end
end