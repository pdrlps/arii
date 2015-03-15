class AddOriginToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :origin, :string
    add_column :feedbacks, :payload, :text
  end
end
