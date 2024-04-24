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
  get 'channeledit' => 'm_channels#edit'
  get 'delete_channel' => 'm_channels#delete'
  post 'channelupdate'=> 'm_channels#update'
  get 'refresh_group' => 'm_channels#refresh_group'

  get 'channeluser' => 'channel_user#show'
  get 'channeluseradd' => 'channel_user#create'
  get 'channeluserdestroy' => 'channel_user#destroy'
  get 'channeluserjoin' => 'channel_user#join'

  get 'groupstar' => 't_group_star_msg#create'
  get 'groupunstar' => 't_group_star_msg#destroy'
  get 'groupstarthread' => 't_group_star_thread#create'
  get 'groupunstarthread' => 't_group_star_thread#destroy'

  get 'delete_groupmsg' => "group_message#deletemsg"
  get 'delete_groupthread' => "group_message#deletethread"


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
  resources :m_channels



end
