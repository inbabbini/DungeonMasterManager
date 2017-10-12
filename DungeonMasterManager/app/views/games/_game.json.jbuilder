json.extract! game, :id, :secret_key, :created_at, :updated_at
json.url game_url(game, format: :json)
