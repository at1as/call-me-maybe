Rails.application.routes.draw do
  root 'conversations#index'
  
  get 'chat',  to: 'chat#index'
  get 'about', to: 'pages#about'
  
  get  'admin', to: 'sessions#new', as: 'login'
  post 'admin', to: 'sessions#create'
  get  'sessions/destroy'  
  get  'users/:id', to: 'users#show', as: 'users_path'
  
  resources 'conversations', except: [:update]
end
