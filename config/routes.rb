Sharebox::Application.routes.draw do
  resources :items
  resource :dropbox, :path => :caja, :controller => :dropbox do
    #match :authorize
    #match :callback
    match   :upload
    get     :refresh
    post    :copy
    delete  :reset
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'access', to: 'sessions#new', as: 'access'

  resource :welcome
  resource :dropbox

  root to: "welcome#index"
end
