Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  scope "(:locale)", locale: /en|vi/ do
    root "pages#index"
    get "/home", to: "pages#index"
    get "/signup", to: "users#new"
    get "/posting", to: "posts#new"
    get "/asking", to: "questions#new"
    resources :users
    resources :posts, only: %i(create destroy)
  end
end
