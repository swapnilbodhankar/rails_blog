class Blog < ApplicationRecord
	belongs_to :category
	delegate :name, to: :category, prefix: true, :allow_nil => true
	def self.search(search)
	  if search
	    where('title LIKE ?', "%#{search}%")
	  else
	    scoped
	  end
	end
end
