
json.token @service_sign_up.payload if @service_sign_up.success?
json.errors @service_sign_up.errors if @service_sign_up.fail?
