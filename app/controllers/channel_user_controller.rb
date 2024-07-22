class ChannelUserController < ApplicationController
  include FaradayApiClient

  def show
    response = get_data("/channeluser?channel_id=#{session[:s_channel_id]}&workspace_id=#{session[:workspace_id]}")
    @c_users_id = response['c_users_id'] || []
    retrieve_group_message
    retrievehome
  end

  def create
    user_id = params[:userid]
    get_data("/channeluserjoin?user_id=#{user_id}&channel_id=#{session[:s_channel_id]}")
    redirect_to channeluser_path
  end

  def join 
    user_id = session[:current_user_id]
    get_data("/channeluserjoin?user_id=#{user_id}&channel_id=#{session[:s_channel_id]}")
    redirect_to m_channel_path(id:session[:s_channel_id] )
  end

  def leave
    get_data("/channeluserdestroy?id=#{params[:id]}&channel_id=#{session[:s_channel_id]}")
    redirect_to home_url
  end

  def destroy
    get_data("/channeluserdestroy?id=#{params[:id]}&channel_id=#{session[:s_channel_id]}")
    puts"---------user#{params[:id]}------------channel#{session[:s_channel_id]} "
    redirect_to channeluser_path
  end
end
