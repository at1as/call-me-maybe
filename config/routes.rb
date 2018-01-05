Rails.application.routes.draw do
  root 'conversations#index'
  
  resources 'conversations', except: [:update]
end
