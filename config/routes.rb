DailySites::Application.routes.draw do
  root :to => 'sites#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout'                 => 'sessions#destroy', :as => :sign_out

  get '/pages/about' => 'pages#about', :as => 'about_page'

  resources :sites, :except => [:show] do
    collection do
      get :all
    end
  end

  resource :session
  resource :profile, :only => [:show, :edit, :update, :destroy]
end
