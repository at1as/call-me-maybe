Rails.application.routes.draw do
  get 'chat', to: 'chat#index'

  root 'conversations#index'
  
  resources 'conversations', except: [:update]
end
