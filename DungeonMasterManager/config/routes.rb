Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#show'

  #Home routes
  get 'home', to: 'home#show', as: 'home'

  #Auth/#sessions routes
  get 'login', to: 'sessions#new', as: 'login_form'
  post 'login', to: 'sessions#create', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  #social login routes
  get 'google_login', to: redirect('/auth/google_oauth2'), as: 'google_login'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  #Special routes
  get 'games/:game_id/campaign_notes/:id/change_visibility', to: 'campaign_notes#change_visibility', as: 'change_game_campaign_note_visibility'
  get 'games/join', to: 'games#join', as: 'games_join'
  post 'games/register', to: 'games#register', as: 'games_register'

  resources :users
  resources :games do
    resources :characters do
      resources :skills
      resources :items
      resources :notes
      resources :achievements
      resources :statuses
      resources :traits
    end
    resources :campaign_notes
    resources :categories
    resources :rules
  end
end
