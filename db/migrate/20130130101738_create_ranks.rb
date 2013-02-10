class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :title
      t.integer :power

      t.timestamps
    end

    Rank.create(:title => 'banned', :power => -1)
    Rank.create(:title => 'unverified', :power => 0)
    Rank.create(:title => 'player-0', :power => 1)
    Rank.create(:title => 'player-1', :power => 1)
    Rank.create(:title => 'player-2', :power => 1)
    Rank.create(:title => 'player-3', :power => 1)
    Rank.create(:title => 'player-4', :power => 1)
    Rank.create(:title => 'player-5', :power => 1)
    Rank.create(:title => 'player-6', :power => 1)
    Rank.create(:title => 'player-7', :power => 1)
    Rank.create(:title => 'player-8', :power => 1)
    Rank.create(:title => 'player-9', :power => 1)
    Rank.create(:title => 'player-10', :power => 1)
    Rank.create(:title => 'staff', :power => 2)
    Rank.create(:title => 'mod', :power => 3)
    Rank.create(:title => 'admin', :power => 4)
    Rank.create(:title => 'god', :power => 5)
  end
end
