class AddMetaToUsers < ActiveRecord::Migration[4.2]
  def change
  	add_column :users, :meta, :text
  end
end
