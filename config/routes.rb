Sharebox::Application.routes.draw do
  resources :items, :path => :caja do
    post    :copy, on: :member
    get     :refresh, on: :collection
    delete  :reset, on: :collection
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'access', to: 'sessions#new', as: 'access'

  match '/', to: 'welcome#index', as: 'home'
  root to: 'welcome#index'
end
