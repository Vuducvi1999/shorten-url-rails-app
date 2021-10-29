
if @result_service.success?
  json.data do
    json.token @result_service.payload 
  end
end

json.errors @result_service.errors if @result_service.fail?
