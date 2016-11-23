class AddDetailsToBlogs < ActiveRecord::Migration[5.0]
  def change
  	add_column :blogs, :category_id, :integer
  	add_column :blogs, :author, :string
  	add_column :blogs, :view_count, :integer
  end
end
