class GroupMessageController < ApplicationController
  include FaradayApiClient
  def show
    #check unlogin user
     

    if session[:s_channel_id].nil?
      redirect_to home_url
    else
      message = params[:session][:message]
      mention_name =params[:session][:memtion_name] 
      data = {
        "message": message,
        "s_channel_id": session[:s_channel_id],
        "mention_name": [mention_name]
      };
      post_data("/groupmsg", data)
     
      redirect_to m_channel_path(session[:s_channel_id])
    end
  end

  def showthread
    
    if session[:s_group_message_id].nil?
      unless session[:s_channel_id].nil?
        redirect_to m_channel_path(session[:s_channel_id])
      end
    elsif session[:s_channel_id].nil?
      redirect_to home_url
    else
      message = params[:session][:message]
      memtion_name = params[:session][:memtion_name] 
      data = {
        "s_group_message_id": session[:s_group_message_id],
        "s_channel_id": session[:s_channel_id],
        "message": message,
        "memtion_name": [memtion_name]
       
      };
      post_data("/groupthreadmsg", data)
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end  

  def deletemsg
    
    if session[:s_channel_id].nil?
      redirect_to home_url
    else  
      get_data("/delete_groupmsg?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&user_id=#{session[:current_user_id]}")
      redirect_to m_channel_path(session[:s_channel_id])
    end  
  end 
  
  def deletethread
    
    if session[:s_channel_id].nil?
      redirect_to home_url
    else  
      get_data("/delete_groupthread?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&s_group_message_id=#{session[:s_group_message_id]}")
      redirect_to t_group_message_path(session[:s_group_message_id])
    end  
  end 
  
end    