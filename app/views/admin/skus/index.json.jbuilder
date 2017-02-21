json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :user_name, :email, :password_digest, :avatar, :status, :confirmed, :token, :reset_token, :reset_at, :bio, :preferences
  json.url user_url(user, format: :json)
end
