Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :queues, only: [:index, :create] do
      collection do
        get 'delete' => "queues#destroy"
      end
    end
    resources :songs, only: [:index]

    get '/playing' => "queues#playing"
  end
end
