class Blog < ApplicationRecord
	belongs_to :category
	has_many :comments
	delegate :name, to: :category, prefix: true, :allow_nil => true
	def self.search(search)
	  if search
	    where('title LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end
end
