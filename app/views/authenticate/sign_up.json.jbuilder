
payload = @result_service.payload

if @result_service.success?
  json.data do
    json.token payload[:jwt] 
    json.user do 
      json.name payload[:user][:name]
      json.email payload[:user][:email]
      json.access_api payload[:user][:access_api]
    end
  end
end

json.errors @result_service.errors if @result_service.fail?
