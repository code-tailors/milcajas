Sharebox::Application.routes.draw do
  resources :items, path: :caja do
    post    :copy, on: :member
    get     :refresh, on: :collection
    delete  :reset, on: :collection
    post    :denounce, on: :member
  end

  resources :users, only: [:destroy]

  resource :tos, only: [:new, :create, :show]

  namespace :admin do
    match "/" => redirect("/admin/items")
    resources :items
    resources :users, only: [:show, :destroy, :show] do
      post :block, on: :member
    end
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'access', to: 'sessions#new', as: 'access'

  match '/', to: 'welcome#index', as: 'home'
  root to: 'welcome#index'
end
