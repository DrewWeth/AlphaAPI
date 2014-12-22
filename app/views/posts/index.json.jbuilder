json.array!(@posts) do |post|
  json.extract! post, :id, :content, :latitude, :longitude, :views, :ups, :downs, :radius
  json.url post_url(post, format: :json)
end
