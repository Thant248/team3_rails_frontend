Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # ログイン前 
  root 'static_pages#welcome'
  get 'welcome' => 'static_pages#welcome'
  get'workspace' => 'm_workspaces#new'
  get 'signin' =>  'sessions#new'
  post 'signin' =>  'sessions#create'
  get 'starlists' => 'star_lists#show'
  get 'thread' => 'thread#show'
  get 'mentionlists' => 'mention_lists#show'
  get 'allunread' => 'all_unread#show'
  get 'usermanage' => 'user_manage#usermanage'
  get 'memberinvite' => 'member_invitation#new'
  post 'memberinvite' => 'member_invitation#invite'
  

  # ログイン後
  # static_pages
  get 'home' =>  'static_pages#home'
  
  # change_password
  get 'change_password' => 'change_password#new'

  # sessions
  delete 'logout' =>  'sessions#destroy'

  resources :m_workspaces, only: [:new, :create]

  

end
