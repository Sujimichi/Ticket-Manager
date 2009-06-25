class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :number
      t.string :title
      t.text :details
      t.integer :project_id
      
      t.boolean :active, :default => true
      t.boolean :on_hold, :default => false
      t.boolean :invalid, :default => false
      
      t.timestamps

    end
  end

  def self.down
    drop_table :tickets
  end
end
