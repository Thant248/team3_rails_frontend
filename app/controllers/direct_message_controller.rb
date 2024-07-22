#Slack System
#Direct Message Controller 
#Authorname-KyawSanWin@CyberMissions Myanmar Company limited 
#@Since 27/06/2019
#Version 1.0.0

class DirectMessageController < ApplicationController
  include FaradayApiClient
  include ActionView::Helpers::SanitizeHelper

  def show
    #check unlogin user
    checkuser
    message = params[:session][:message]
    draft_status = params[:session][:draft_status]
    if session[:s_user_id].nil?
      redirect_to home_url
    elsif params[:session][:message].blank?
      redirect_to m_user_path(session[:s_user_id])
    else
      data = {
        "message": message,
        "user_id": session[:current_user_id],
        "s_user_id": session[:s_user_id],
        "draft_message_status": draft_status,
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
    elsif params[:session][:message].blank?
      redirect_to t_direct_message_path(session[:s_direct_message_id])    
    else
      data =  {
        "s_direct_message_id": session[:s_direct_message_id],
        "s_user_id": session[:s_user_id],
        "message": params[:session][:message],
        "user_id": session[:current_user_id],
        "draft_message_status": params[:session][:draft_status],
      };
        post_data("/directthreadmsg", data)
        redirect_to t_direct_message_path(session[:s_direct_message_id])
    end
  end

  # send thread directly from thread lists
  def showthreaddirectly
    #check unlogin user
     checkuser

    if params[:session][:t_direct_message_id].nil?
      redirect_to thread_url
    elsif params[:session][:t_direct_message_id].nil?
      redirect_to home_url
    elsif params[:session][:message].blank?
      redirect_to thread_url
    else
      data =  {
        "s_direct_message_id": params[:session][:t_direct_message_id],
        "s_user_id": params[:session][:t_directmsg_sender_id],
        "message": params[:session][:message],
        "user_id": session[:current_user_id],
        "draft_message_status": 0,
      };
      post_data("/directthreadmsg", data)
      redirect_to thread_url
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

  # message edit 
  def edit
    if params[:id].nil?
      redirect_to home_url
    else
      response = get_data("/directmsg/edit/#{params[:id]}")
      @dataraw = response["message"]["directmsg"]
      @data = sanitize(@dataraw, tags: %w(p span div br strong em a blockquote s ul ol li), attributes: %w(href class style))
      retrievehome
      retrieve_direct_message
      render "direct_show/_edit"
      # redirect_to m_user_path(session[:s_user_id])
    end
  end

  def update
    if params[:action_type] == 'send' || params[:session][:draft_status] 
      id = params[:id]
      message = params[:session][:message]
      data = {
        id: id,
        message: message
      }
      post_data( "/update_directmsg", data)
      redirect_to m_user_path(session[:s_user_id])
    else
      redirect_to m_user_path(session[:s_user_id])
    end
  end

  def edit_thread
    if params[:id].nil?
      redirect_to home_url
    else
      response = get_data("/directthreadmsg/edit/#{params[:id]}")
      @dataraw = response["message"]["directthreadmsg"]
      @data = sanitize(@dataraw, tags: %w(p span div br strong em a blockquote s ul ol li), attributes: %w(href class style))
      retrievehome
      retrieve_direct_thread
      render "direct_thread_show/_editthread"
    end
  end

  def update_thread
    if params[:action_type] == 'send' || params[:session][:draft_status]
      id = params[:id]
      message = params[:session][:message]
      data = {
        id: id,
        message: message
      }
      post_data( "update_directthreadmsg", data)
      redirect_to t_direct_message_path(session[:s_direct_message_id])
    else 
      redirect_to t_direct_message_path(session[:s_direct_message_id])
    end
  end

end
