Rails.application.routes.draw do

  root to: 'mailboxes#index'

  post '/m/:token', to: 'messages#create', as: :external_message
  
  resources :mailboxes do
    resources :messages
  end
end
