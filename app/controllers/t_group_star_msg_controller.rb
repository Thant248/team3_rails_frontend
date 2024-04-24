class TGroupStarMsgController < ApplicationController
  def create
    if session[:s_channel_id].nil?
      redirect_to home_url
    else  
      get_data("/groupstar?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&user_id=#{session[:current_user_id]}")
      redirect_to m_channel_path(session[:s_channel_id])
    end  
  end 

  def destroy
    if session[:s_channel_id].nil?
      redirect_to home_url
    else  
      get_data("/groupunstar?s_channel_id=#{session[:s_channel_id]}&id=#{params[:id]}&user_id=#{session[:current_user_id]}")
      redirect_to m_channel_path(session[:s_channel_id])
    end  
  end    
end    