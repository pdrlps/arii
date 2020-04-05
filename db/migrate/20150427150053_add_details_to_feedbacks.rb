class AddDetailsToFeedbacks < ActiveRecord::Migration[4.2]
  def change
    add_column :feedbacks, :details, :string
  end
end
