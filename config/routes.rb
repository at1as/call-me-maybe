Rails.application.routes.draw do
  root 'conversations#index'
  
  get 'chat',  to: 'chat#index'
  get 'about', to: 'pages#about'
  
  resources 'conversations', except: [:update]
end
