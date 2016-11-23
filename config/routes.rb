Rails.application.routes.draw do
  resources :blogs do
  	collection do
      post :post_comment
    end
  end
  root :to => 'blogs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/sort" => "blogs#sort"

   match "/blogs/:id/delete", :to => "blogs#destroy", :via => ["delete"]
end
