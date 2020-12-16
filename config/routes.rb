Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :users do
				resources :facts 
			end
			post 'signup', to: 'users#create', as: :signup
      post 'login', to: 'users#login'
		end
	end
end
