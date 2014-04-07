Instabooks::Application.routes.draw do
  match 'auth/instagram', to: 'sessions#connect'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :albums do
    resources :photos, :except => [:show]
  end

  get 'photo/:album_id/photo/:id', to: 'photos#show_photo', as: 'photo'
  root to: 'application#index'

  get 'load_photos', to: 'application#load_photos'
end
