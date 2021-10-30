Rails.application.routes.draw do
  root 'home_page#home'
  
  post 'sign-in' => 'authenticate#sign_in'
  post 'sign-up' => 'authenticate#sign_up'
  
  post 'compress' => 'shorten_url#compress'
  
  get 'access-api' => 'management#access_api'
  get 'links' => 'management#links'
  get 'detail/:alias' => 'management#detail'
  post 'destroy/:alias' => 'management#destroy'
  post 'edit/:alias' => 'management#edit'
  
  get ':alias' => 'shorten_url#direct'
end
