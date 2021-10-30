
payload = @result_service.payload
errors = @result_service.errors

if payload.present?
  json.data do
    json.origin_url payload.origin
    json.shorten_url shorten_url payload
    json.clicked payload.clicked
    json.user do 
      json.(payload.user, :name, :email, :access_api)
    end
  end
end

json.errors errors if payload.nil?