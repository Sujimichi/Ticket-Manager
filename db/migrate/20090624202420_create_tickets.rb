class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :number
      t.string :title

    end
  end

  def self.down
    drop_table :tickets
  end
end
