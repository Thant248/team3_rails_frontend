class StaticPagesController < ApplicationController
  # before_action :check_user

  def welcome
  end

  def home    
    # ここに必要なデータをAPIから取得する
    response = get_data('/main')

   
    @current_user = response["current_user"]
    @m_user = @current_user["name"]
    @workspace_name = response["m_workspace"]["workspace_name"]

    # Add more instance variables if needed
    @m_users = response["m_users"]
    @m_channels = response["m_channels"]
    @m_p_channels = response["m_p_channels"]
    @direct_msgcounts = response["direct_msgcounts"]
    @all_unread_count = response["all_unread_count"]
    @m_channelsids = response["m_channelsids"]
  end
end



