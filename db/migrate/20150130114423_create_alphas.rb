class CreateAlphas < ActiveRecord::Migration
  def change
    create_table :alphas do |t|
      t.string :name
      t.string :email
      t.string :job

      t.timestamps
    end
  end
end
