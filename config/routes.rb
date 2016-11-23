Rails.application.routes.draw do
  resources :blogs
  root :to => 'blogs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/sort" => "blogs#sort"
end
