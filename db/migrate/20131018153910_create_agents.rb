class CreateAgents < ActiveRecord::Migration[4.2]
  def change
    create_table :agents do |t|
      t.string :publisher
      t.text :payload
      t.text :memory
      t.string :identifier
      t.string :title
      t.text :help
      t.string :schedule
      t.integer :events_count
      t.integer :status, :default => 100
      t.datetime :last_check_at

      t.timestamps
    end

    add_index :agents, :identifier, :unique => true
  end
end
