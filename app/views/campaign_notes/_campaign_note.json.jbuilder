json.extract! campaign_note, :id, :title, :content, :visible_by_players, :dm_annotation, :text, :created_at, :updated_at
json.url campaign_note_url(campaign_note, format: :json)
