class AddActiveToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :active, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :active
  end
end
