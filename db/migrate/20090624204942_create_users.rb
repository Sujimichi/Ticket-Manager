class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      t.boolean :sys_admin, :default => false

      t.timestamps

    end
    User.create!(:username => "Kat", :password => "foobar",  :password_confirmation => "foobar", :email => "kat@kat.com")
  end

  def self.down
    drop_table :users
  end
end
