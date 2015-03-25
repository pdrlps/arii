json.array!(@betas) do |beta|
  json.extract! beta, :id, :origin, :name, :email, :job, :payload, :what
  json.url beta_url(beta, format: :json)
end
