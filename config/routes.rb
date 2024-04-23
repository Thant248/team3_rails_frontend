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
  get 'confirminvitation' => 'm_users#confirm'

  get 'usermanage' => 'user_manage#usermanage'
  get 'edit' => 'user_manage#edit'
  get 'update' => 'user_manage#update'

  get 'channelcreate' => 'm_channels#new'
  post 'channelcreate' => 'm_channels#create'

  get 'refresh_direct' => 'm_users#refresh_direct'

  post 'directmsg' => 'direct_message#show'

  get 'refresh' => 'sessions#refresh'
  

  # ログイン後
  # static_pages
  get 'home' =>  'static_pages#home'
  
  # change_password
  get 'change_password' => 'change_password#new'


  get 'star' => 't_direct_star_msg#create'
  get 'unstar' => 't_direct_star_msg#destroy'
  get 'delete_directmsg' => "direct_message#deletemsg"

  get 'delete_directthread' => "direct_message#deletethread"
  post 'directthreadmsg' => 'direct_message#showthread'
  get 'starthread' => 't_direct_star_thread#create'
  get 'unstarthread' => 't_direct_star_thread#destroy'

  # sessions
  delete 'logout' =>  'sessions#destroy'

  resources :m_workspaces, only: [:new, :create]
  resources :m_users, only: [:new, :create, :show, :refresh_direct]
  resources :t_direct_messages



end
