DailySites::Application.routes.draw do
  root :to => 'sites#index'

  resources :sites, :except => [:show] do
    collection do
      get :all
    end
  end
end
