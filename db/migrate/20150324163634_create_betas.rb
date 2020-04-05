class CreateBetas < ActiveRecord::Migration[4.2]
  def change
    create_table :betas do |t|
      t.string :origin
      t.string :name
      t.string :email
      t.string :job
      t.text :payload
      t.text :what

      t.timestamps null: false
    end
  end
end
