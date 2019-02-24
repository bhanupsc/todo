Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    root to: "devise/sessions#new"  
  end
  

  resources :catagories do
  	resources :tasks do
  		put :sort, on: :collection
  		put :update_status
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
