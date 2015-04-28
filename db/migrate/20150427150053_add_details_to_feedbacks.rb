class AddDetailsToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :details, :string
  end
end
