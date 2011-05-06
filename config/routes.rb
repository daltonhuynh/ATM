Atm::Application.routes.draw do

  resources :accounts, :only => [:index, :show] do
    resources :withdrawals, :only => [:new, :create]
  end
  
  resources :withdrawals, :only => [:new, :create]
  resources :sessions, :only => [:new, :create, :destroy]

  match "login" => "sessions#new"
  match "logout" => "sessions#destroy"

  root :to => "sessions#new"

end
