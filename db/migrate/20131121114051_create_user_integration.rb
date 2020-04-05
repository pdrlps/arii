class CreateUserIntegration < ActiveRecord::Migration[4.2]
  def change
    create_table :user_integrations do |t|
      t.belongs_to :user
      t.belongs_to :integration
      t.integer :status, :default => 100
      t.timestamps
    end
  end
end