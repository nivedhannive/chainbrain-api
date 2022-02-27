json.array!(@file.data) do |data|
  json.name data.name
  json.email data.email
  json.created_at data.created_at
  json.updated_at data.updated_at
end