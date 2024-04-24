#Slack System
#Direct Message Controller 
#Authorname-KyawSanWin@CyberMissions Myanmar Company limited 
#@Since 27/06/2019
#Version 1.0.0

class DirectMessageController < ApplicationController
  include FaradayApiClient

  def show
    #check unlogin user
    checkuser

    if session[:s_user_id].nil?
      redirect_to home_url
    else
      message = params[:session][:message]
      data = {
        "message": message,
        "user_id": session[:current_user_id],
        "s_user_id": session[:s_user_id]
      };
     
      post_data("/directmsg", data)
     
      redirect_to m_user_path(session[:s_user_id])
    end
  end

  def showthread
    #check unlogin user
     checkuser

    if session[:s_direct_message_id].nil?
      unless session[:s_user_id].nil?
        redirect_to m_user_path(session[:s_user_id])
      end
    elsif session[:s_user_id].nil?
      redirect_to home_url
    else
      data =  {
        "s_direct_message_id": session[:s_direct_message_id],
        "s_user_id": session[:s_user_id],
        "message": params[:session][:message],
        "user_id": session[:current_user_id]
      };
        post_data("/directthreadmsg", data)
        redirect_to t_direct_message_path(session[:s_direct_message_id])
      
    end
  end

  def deletemsg
    #check unlogin user
    checkuser

    if session[:s_user_id].nil?
      redirect_to home_url
    else
      get_data("/delete_directmsg?id=#{params[:id]}")
      redirect_to m_user_path(session[:s_user_id])
    end 
    
  end

  def deletethread
    #check unlogin user
     checkuser
    if session[:s_direct_message_id].nil?
      unless session[:s_user_id].nil?
        redirect_to  t_direct_message_path(session[:s_direct_message_id])
      end
    elsif session[:s_user_id].nil?
      redirect_to home_url
    else
      get_data("/delete_directthread?s_direct_message_id=#{session[:s_direct_message_id]}&s_user_id=#{session[:s_user_id]}&id=#{params[:id]}")
      redirect_to t_direct_message_path(session[:s_direct_message_id])
    end
  end

end
