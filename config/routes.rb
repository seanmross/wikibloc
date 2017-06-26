Rails.application.routes.draw do

  resources :wikis

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'users/:id/account/edit', to: 'users#edit', as: 'edit_user_account'
  patch 'users/:id/account/edit' => 'users#update'

  get 'welcome/index'
  get 'welcome/about' => 'welcome#index'

  root 'welcome#index'
end
