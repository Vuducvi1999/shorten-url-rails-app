
# check_access!     require access_api or token
# authorized!       require token


Rails.application.routes.draw do
  root 'home_page#home'                           # public
  
  post 'sign-in' => 'authenticate#sign_in'        # authorized!
  post 'sign-up' => 'authenticate#sign_up'        # authorized!
  
  post 'compress' => 'shorten_url#compress'       # check_access!
  
  get 'access-api' => 'management#access_api'     # authorized!
  get 'links' => 'management#links'               # check_access!
  get 'detail/:alias' => 'management#detail'      # check_access!
  post 'destroy/:alias' => 'management#destroy'   # check_access!
  post 'edit/:alias' => 'management#edit'         # check_access!
  
  get ':alias' => 'shorten_url#direct'            # public
end
