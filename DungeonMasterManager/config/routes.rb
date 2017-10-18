Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#show'

  #Home routes
  get 'home', to: 'home#show', as: 'home'
  get 'signin', to: 'home#signin', as: 'signin'

  #Auth/sessions routes
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'google_login', to: redirect('/auth/google_oauth2'), as: 'google_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  #users routes
  get 'myprofile', to: 'users#show', as: 'myprofile'
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch 'users/:id', to: 'users#update', as: 'update_user'
  delete 'users', to: 'user#destroy', as: 'delete_user'


  resources :games do
    resources :characters do
      resources :skills
      resources :items
      resources :notes
      resources :achievements
    end
    resources :campaign_notes
    resources :categories
    resources :rules
  end
end
