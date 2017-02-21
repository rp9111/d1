json.array!(@pages) do |page|
  json.extract! page, :id, :title, :content, :cover, :permalink, :area_id, :commentable, :properties, :position, :user_id, :publish, :published_at, :pull_at
  json.url page_url(page, format: :json)
end
