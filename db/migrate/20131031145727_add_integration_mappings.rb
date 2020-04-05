class AddIntegrationMappings < ActiveRecord::Migration[4.2]
     create_table :integration_mappings do |t|
      t.belongs_to :integration
      t.belongs_to :template
      t.timestamps
    end
end