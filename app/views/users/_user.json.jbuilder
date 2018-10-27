json.extract! user, :id, :loginid, :created_at, :updated_at
json.url user_url(user, format: :json)
