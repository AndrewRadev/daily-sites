DailySites::Application.routes.draw do
  root :to => 'sites#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/signout'                 => 'sessions#destroy', :as => :sign_out

  resources :sites, :except => [:show] do
    collection do
      get :all
    end
  end

  resource :session
end
