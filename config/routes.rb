Rails.application.routes.draw do
  post 'sign-in' => 'authenticate#sign_in'
  post 'sign-up' => 'authenticate#sign_up'
end
