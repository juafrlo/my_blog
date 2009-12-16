class AddExtraFieldToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :extra_field, :string
  end

  def self.down
    remove_column :comments, :extra_field
  end
end
