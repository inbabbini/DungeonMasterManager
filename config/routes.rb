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
  get 'games/:game_id/characters/:id/reassign/:user_id', to: 'characters#reassign', as: 'reassign_games_character'

  #Locale routes
  get 'locale/:locale_abbr', to: 'locales#change_locale', as: 'change_locale'

  resources :users, except: :index
  resources :games do
    resources :characters do
      resources :skills, except: [:index, :show]
      resources :items, except: [:index, :show]
      resources :notes, except: :index
      resources :achievements, except: [:index, :show]
      resources :statuses, except: [:index, :show]
      resources :traits, except: [:index, :show]
    end
    resources :campaign_notes
    resources :categories
    resources :rules
  end
end
