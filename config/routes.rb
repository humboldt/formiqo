Rails.application.routes.draw do

  # devise_scope :user do
  #   get 'login', to: 'sessions#new'
  #   get 'register', to: 'registrations#new'
  # end

  devise_for :users,
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations',
      passwords: 'passwords',
    },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
    }

  root to: 'mailboxes#index'

  post '/m/:token', to: 'messages#create', as: :external_message

  resources :subscriptions
  resources :mailboxes do
    resources :messages
    member do
      post 'clear_messages', to: 'mailboxes#clear_messages'
    end
  end

  # post '/checkout', to: 'payment#checkout'
  get '/execute', to: 'payment#execute'

end
