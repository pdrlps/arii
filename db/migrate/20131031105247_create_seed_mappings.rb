class CreateSeedMappings < ActiveRecord::Migration[4.2]
  def change
    create_table :seed_mappings do |t|
    	t.belongs_to :agent
      	t.belongs_to :seed
      	t.timestamps
    end
  end
end
