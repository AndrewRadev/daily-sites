DailySites::Application.routes.draw do
  root :to => 'sites#index'

  post 'omniauth/callback'         => 'omniauth#callback', :as => :omniauth
  match '/auth/:provider/callback' => 'omniauth#callback'

  match '/signout'                 => 'sessions#destroy', :as => :sign_out

  get '/pages/about' => 'pages#about', :as => 'about_page'
  get '/pages/login' => 'pages#login', :as => 'login_page'

  resources :sites, :except => [:show] do
    collection do
      get :all
    end
  end

  resource :session, :only => [:destroy]
  resource :profile, :only => [:show, :edit, :update, :destroy]

  if Rails.env.development?
    get '/backdoor(/:id)' => 'sessions#backdoor'
  end
end
