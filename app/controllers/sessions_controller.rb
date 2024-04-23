  class SessionsController < ApplicationController
    include FaradayApiClient
    
    def new
    end

    def create
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
      unless session[:user_id].nil?
        retrievehome
      end
    end
  end
