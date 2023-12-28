Rails.application.routes.draw do
  resources :posts do
    member do
    # post :sendmail
      get 'sendmail'
      # post 'send_post_pdf'

    end
  end
  post '/send_post_pdf', to: 'posts#send_post_pdf'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  # root "welcome#index"
  get "/send_mail" => "welcome#send_mail"
  # get "/mailer" => "post#mailer"

  require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
end
