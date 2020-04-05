class AddSeedToCache < ActiveRecord::Migration[4.2]
  def change
  	add_column :caches, :seed, :string
  end
end
