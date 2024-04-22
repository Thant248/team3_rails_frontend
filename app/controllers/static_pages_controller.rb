class StaticPagesController < ApplicationController
  include FaradayApiClient
  # before_action :check_user

  def welcome
  end

  def home    
    # ここに必要なデータをAPIから取得する
    response = get_data('/main')
    
    @current_user = response["current_user"]
    @m_user = @current_user["name"]
    @current_user_id = @current_user["id"]
    @current_user_admin = @current_user["admin"]
    @workspace_name = response["m_workspace"]["workspace_name"]
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
  end
end



