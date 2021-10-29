
json.token @service_sign_in.payload if @service_sign_in.success?
json.errors @service_sign_in.errors if @service_sign_in.fail?
