json.array!(@areas) do |area|
  json.extract! area, :id, :name, :label, :navigation, :footer, :comments, :position, :ascending, :mode
  json.url area_url(area, format: :json)
end
