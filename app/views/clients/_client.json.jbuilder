json.extract! client, :id, :name, :email, :birth_date, :created_at, :updated_at
json.url client_url(client, format: :json)
