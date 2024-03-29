Rails.application.routes.draw do
  root 'static_pages#top'

  get    '/login',   to: 'user_sessions#new'
  post   '/login',   to: 'user_sessions#create'
  delete '/logout',  to: 'user_sessions#destroy'
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
    resources :boards, only: %i[index show edit update destroy]
  end

  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    # /users/bookmarksにアクセスすると、userコントローラのbookmarksアクションが実行される
    collection do
      get 'bookmarks'
    end
  end
  resources :bookmarks, only: %i[index create destroy]
  resources :users, only: %i[new create]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
