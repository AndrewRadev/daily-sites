Rails.application.routes.draw do
  root to: 'sites#index'

  post 'omniauth/callback'        => 'omniauth#callback', as: :omniauth
  post '/auth/:provider/callback' => 'omniauth#callback'

  delete '/signout' => 'sessions#destroy', as: :sign_out

  get '/pages/about' => 'pages#about', as: 'about_page'
  get '/pages/login' => 'pages#login', as: 'login_page'

  resources :sites do
    collection do
      get :all
    end
  end

  get '/sites/daily/:day' => 'sites#daily'

  resource :session
  resource :profile

  if Rails.env.development?
    get '/backdoor(/:id)' => 'sessions#backdoor'
  end
end
