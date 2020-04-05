class AddOriginToFeedbacks < ActiveRecord::Migration[4.2]
  def change
    add_column :feedbacks, :origin, :string
    add_column :feedbacks, :payload, :text
  end
end
