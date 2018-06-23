Rails.application.routes.draw do
  resources :skus do 
  	collection do
  		post :import
  		get :percentage_done
  	end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "dashboard#home"

  get "home" => "dashboard#home", as: :dashboard
end
