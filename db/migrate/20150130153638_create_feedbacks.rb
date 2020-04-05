class CreateFeedbacks < ActiveRecord::Migration[4.2]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
