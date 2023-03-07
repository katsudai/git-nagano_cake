Rails.application.routes.draw do
  
  
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about"
    resources :items, only: [:index, :show]
    
    get "customers/my_page" => "customers#show"
    get "customers/infomation/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    
    delete "cart_items/all_destroy" => "cart_items#all_destroy"
    resources :cart_items, only: [:index, :update, :create, :destroy]
    get "orders/complete" => "orders#complete"
    resources :orders, only: [:new, :index, :create, :show]
    post "orders/confirm" => "orders#confirm"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  
  # 管理者用
  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :customers, only: [:index, :edit, :show, :update]
    resources :orders, only: [:show, :index]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end