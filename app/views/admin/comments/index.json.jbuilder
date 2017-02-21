json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :page_id, :content, :submitted_at, :approved, :posted_at
  json.url comment_url(comment, format: :json)
end
