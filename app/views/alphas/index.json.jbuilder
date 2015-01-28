json.array!(@alphas) do |alpha|
  json.extract! alpha, :id, :email
  json.url alpha_url(alpha, format: :json)
end
