class AddEndpointToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :endpoint, :string
  end
end
