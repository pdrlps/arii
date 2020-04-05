class AddAgentMappings < ActiveRecord::Migration[4.2]
   create_table :agent_mappings do |t|
      t.belongs_to :integration
      t.belongs_to :agent
      t.timestamps
  end
end
