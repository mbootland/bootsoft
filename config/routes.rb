Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'cv', to: 'cv#show'
    end
  end
end