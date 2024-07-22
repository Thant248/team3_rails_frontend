class TGroupStarThreadController < ApplicationController
  def create
    #check unlogin user
    # checkuser

    if session[:s_group_message_id].nil?
      unless session[:s_channel_id].nil?
          redirect_to m_channel_path(session[:s_channel_id])
      end
    elsif session[:s_channel_id].nil?
      redirect_to home_url
    else
      get_data("/groupstarthread?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&s_group_message_id=#{session[:s_group_message_id]}")
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end

  def destroy
    if session[:s_group_message_id].nil?
      unless session[:s_channel_id].nil?
        redirect_to m_channel_path(session[:s_channel_id])
      end
    elsif session[:s_channel_id].nil?
      redirect_to home_url
    else
      get_data("/groupunstarthread?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&s_group_message_id=#{session[:s_group_message_id]}")
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end
end