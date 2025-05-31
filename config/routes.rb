Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    devise_for :users,
      path: '',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'api/users/sessions',
        registrations: 'api/users/registrations'
      }

    get '/products', to: 'products#index'
  end
end

