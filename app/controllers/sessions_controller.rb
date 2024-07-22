class SessionsController < ApplicationController
  include FaradayApiClient
  
  def new
    #check login user
    checkloginuser
  end

  def create
    #check login user
    checkloginuser

    name = params[:session][:name]
    password = params[:session][:password]
    workspace_name = params[:session][:workspace_name]
    data = { name:, password:, workspace_name:}
    # 認証チェック
    result = make_login('/login', { user: data })
    # logger.debug result
    
    # ログイン失敗
    if result.nil?
      flash.now[:danger] = 'Invalid name/password combination'
      render 'new'
    else
      # Check user deactive status here　　

      # ログイン成功
      # 認証済情報設定
      log_in(result)
      redirect_to home_url
    end
  end

  def destroy
    #①APIのログアウトをCALLする
    make_logut('/logout')
    log_out
  end

  def refresh
    unless session[:current_user_id].nil?
      
      if session[:current_user_id]
        if session[:s_direct_message_id] != nil && session[:s_direct_message_id] != ""
          #call from ApplicationController for retrieve direct thread data
          retrieve_direct_thread

        elsif session[:s_user_id] != nil && session[:s_user_id] != ""    
          #call from ApplicationController for retrieve direct message data
          retrieve_direct_message

        elsif session[:s_group_message_id] != nil && session[:s_group_message_id] != ""
          #call from ApplicationController for retrieve group thread data
          retrieve_group_thread

        elsif session[:s_channel_id] != nil && session[:s_channel_id] != ""
          #call from ApplicationController for retrieve group message data
          retrieve_group_message

        end
        
        #call from ApplicationController for retrieve home data
        retrievehome

      end
    end
  end
end
