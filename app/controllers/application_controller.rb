class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include FaradayApiClient
  include SessionsHelper


  def retrievehome
  end

  def retrieve_direct_message
  end

  def retrieve_direct_thread
  end

  def retrieve_group_message
  end

  def retrieve_group_thread
  end

  def check_user
    if session[:workspace_id].nil?
      redirect_to home_url
    else
      # m_user = MUser.find_by(id: session[:user_id], member_status: 1)
      m_user = session[:user_id]
      if m_user.nil?
        session.delete(:workspace_id)
        session.delete(:s_channel_id)
        session.delete(:s_user_id)
        session.delete(:s_direct_message_id)
        session.delete(:s_group_message_id)
        
        flash.clear
        # log_out if logged_in?
        # ログアウト用のAPIをCALLする
        redirect_to home_url
      end
    end
  end

  def check_login_user
    unless session[:workspace_id].nil?
      redirect_to home_url
    end
  end
end
