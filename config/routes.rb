Rails.application.routes.draw do
  namespace :v1 do
    resources :countries
    resources :departments
    resources :employees
  end
end
