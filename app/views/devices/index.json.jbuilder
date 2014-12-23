json.array!(@devices) do |device|
  json.extract! device, :id, :auth_key
  json.url device_url(device, format: :json)
end
