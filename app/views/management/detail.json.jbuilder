
payload = @result_service.payload 
errors = @result_service.errors

json.data do 
  json.origin_url payload.origin 
  json.shorten_url shorten_url payload
  json.clicked payload.clicked
  json.created_at payload.created_at
  json.updated_at payload.updated_at
end if payload.present?

json.errors errors if payload.nil?
