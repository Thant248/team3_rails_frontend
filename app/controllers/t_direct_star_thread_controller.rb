#Slack System
#Direct Message Controller 
#Authorname-KyawSanWin@CyberMissions Myanmar Company limited 
#@Since 27/06/2019
#Version 1.0.0

class TDirectStarThreadController < ApplicationController
  def create
    # #check unlogin user
    # checkuser

    if session[:s_direct_message_id].nil?
      unless session[:s_user_id].nil?
        redirect_to redirect_to m_user_path(session[:s_user_id])
      end
    elsif session[:s_user_id].nil?
      redirect_to home_url
    else
      get_data("/starthread?s_user_id=#{session[:s_user_id]}&user_id=#{session[:current_user_id]}&id=#{params[:id]}&s_direct_message_id=#{session[:s_direct_message_id]}")
      redirect_to t_direct_message_path(session[:s_direct_message_id])
    end
  end

  def destroy
    #check unlogin user
    # checkuser

    if session[:s_direct_message_id].nil?
      unless session[:s_user_id].nil?
       
        redirect_to t_direct_message_path(session[:s_direct_message_id])
      end
    elsif session[:s_user_id].nil?
      redirect_to home_url
    else
      get_data("/unstarthread?s_direct_message_id=#{session[:s_direct_message_id]}&s_user_id=#{session[:s_user_id]}&id=#{params[:id]}&user_id=#{session[:current_user_id]}")
      redirect_to t_direct_message_path(session[:s_direct_message_id])
    end
  end
end
