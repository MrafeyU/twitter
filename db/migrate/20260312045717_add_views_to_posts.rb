class AddViewsToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :views, :integer
  end
end
