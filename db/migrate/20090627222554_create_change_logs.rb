class CreateChangeLogs < ActiveRecord::Migration
  def self.up
    create_table :change_logs do |t|
      t.integer :ticket_id
      t.string :log

    end
  end

  def self.down
    drop_table :change_logs
  end
end
