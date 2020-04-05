class CreateUserAgent < ActiveRecord::Migration[4.2]
  def change
    create_table :user_agents do |t|
      t.belongs_to :user
      t.belongs_to :agent
      t.integer :status, :default => 100
      t.timestamps
    end
  end
end