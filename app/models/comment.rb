class Comment < ApplicationRecord
  belongs_to :blog
  def self.add_comment(comment,name,blog)
  	self.create(:blog_id => blog.id,name: name, :comment => comment)
  end
end
