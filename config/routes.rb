Rails.application.routes.draw do
  root 'static_pages#top'

  get    '/login',   to: 'user_sessions#new'
  post   '/login',   to: 'user_sessions#create'
  delete '/logout',  to: 'user_sessions#destroy'

  resources :boards do
    resources :comments, only: %i[create destroy], shallow: true
    # /users/bookmarksにアクセスすると、userコントローラのbookmarksアクションが実行される
    collection do
      get 'bookmarks'
    end
  end
  resources :bookmarks, only: %i[index create destroy]
  resources :users, only: %i[new create]
  resources :password_resets, only: [:create, :edit, :update]
  resource :profile, only: %i[show edit update]
end
