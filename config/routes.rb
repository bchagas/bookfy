Instabooks::Application.routes.draw do
  match 'auth/instagram', to: 'sessions#connect'
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :albums do
    resources :photos, :except => [:show] do
      collection { post :sort }
    end
  end

  get 'album/:album_id/photo/:id', to: 'photos#show_photo', as: 'photo'
  get 'load_photos', to: 'application#load_photos'
  get 'home', to: 'application#home', as: 'home'

  root to: 'application#home'
end
