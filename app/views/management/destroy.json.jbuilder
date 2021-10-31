
payload = @result_service.payload 
errors = @result_service.errors

json.data payload if payload.present?

json.errors errors if payload.nil?
