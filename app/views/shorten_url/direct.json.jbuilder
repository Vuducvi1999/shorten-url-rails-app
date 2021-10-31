
payload = @result_service.payload
errors = @result_service.errors

if payload.present?
  json.data do
    json.origin_url payload.origin
  end
end

json.errors errors if payload.nil?