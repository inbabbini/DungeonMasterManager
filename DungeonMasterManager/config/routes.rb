Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#show'

  get 'home', to: 'home#show', as: 'home'
  get 'signin', to: 'home#signin', as: 'signin'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'google_login', to: redirect('/auth/google_oauth2'), as: 'google_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'myprofile', to: 'users#show', as: 'myprofile'


  resources :games do
    resources :characters do
      resources :skills
      resources :items
      resources :notes
      resources :achievements
    end
    resources :rules
  end
end
