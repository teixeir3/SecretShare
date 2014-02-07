SecretShareAjax::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :index] do
    member do
      resources :secrets, only: :new
    end
  end

  resources :friendships, only: [:create, :destroy]

  resources :secrets, except: :new
  resource :session, :only => [:create, :destroy, :new]

  root :to => "users#show"
end
