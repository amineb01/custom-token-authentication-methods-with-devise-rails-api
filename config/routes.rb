Rails.application.routes.draw do

  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post    'sessions'  => 'sessions#create',     as: 'login'
        delete  'sessions'  => 'sessions#destroy',    as: 'logout'
      end
      get "ressources" => "ressources#index"
    end

  end

end
