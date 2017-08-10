Rails.application.routes.draw do

  get 'pages/index'
  get 'pages/help'
  get 'pages/terms'

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
    },
    skip: [:sesstions] do
      get "/register"   => "users/registrations#new",   :as => :new_user_registration
    end

  root to: 'pages#index'

  post '/m/:token', to: 'messages#create', as: :external_message

  resources :subscriptions, only: [:index, :create, :update]
  resources :mailboxes do
    resources :messages, only: [:index, :create, :destroy]
    member do
      post 'clear_messages', to: 'mailboxes#clear_messages'
    end
  end

  # post '/checkout', to: 'payment#checkout'
  get '/execute', to: 'payment#execute'

end
