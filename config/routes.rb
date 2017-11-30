Rails.application.routes.draw do
  #get 'conversations/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources 'conversations', except: [:update]
end
