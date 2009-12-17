class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :body
      t.string :site_url
      t.string :extra_field
      t.string :user_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
