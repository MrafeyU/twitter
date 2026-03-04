class AddUserIdToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :user_id, :string
  end
end
