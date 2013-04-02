Instabooks::Application.routes.draw do
  match 'auth/instagram', to: 'sessions#connect'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  #resources :photos
  root to: 'application#index'
end
