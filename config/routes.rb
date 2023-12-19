Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :offers, only: :index

  root to: "offers#index"
end
