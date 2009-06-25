class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.boolean :completed, :default => false
      t.boolean :active, :default => true

    end
  end

  def self.down
    drop_table :projects
  end
end
