class CreateAlphas < ActiveRecord::Migration
  def change
    create_table :alphas do |t|
      t.string :email

      t.timestamps
    end
  end
end
