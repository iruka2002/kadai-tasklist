Rails.application.routes.draw do
 root to: 'tasks#index'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
 
 get 'signup', to: 'tasks#new'
 resources :tasks, only: [:index, :show, :new, create]
end
