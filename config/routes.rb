DailySites::Application.routes.draw do
  root :to => 'sites#index'

  get '/auth/:provider/callback' => 'sessions#create'

  resources :sites, :except => [:show] do
    collection do
      get :all
    end
  end
end
