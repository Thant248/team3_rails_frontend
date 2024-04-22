class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include FaradayApiClient
  include SessionsHelper


  def retrievehome
    response = get_data('/main')

    @m_channels = MChannel.new

    @current_user = response["current_user"]
    @m_user = @current_user["name"]
    @current_user_id = @current_user["id"]
    @current_user_admin = @current_user["admin"]
    @workspace_name = response["m_workspace"]["workspace_name"]
    @workspace_id = response["m_workspace"]["id"]
    # Add more instance variables if needed
    @m_users = response["m_users"]
    @m_channels = response["m_channels"]
    @m_p_channels = response["m_p_channels"]
    @direct_msgcounts = response["direct_msgcounts"]
    @all_unread_count = response["all_unread_count"]
    @m_channelsids = response["m_channelsids"]

    session[:current_user_id] = @current_user_id
    session[:m_channels] = response["m_channels"]
    session[:m_users] = response["m_users"]
    session[:m_p_channels] = response["m_p_channels"]
    session[:m_channelsids] = response["m_channelsids"]
    session[:m_user] = @current_user["name"]
    session[:workspace_id] = @workspace_id
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
