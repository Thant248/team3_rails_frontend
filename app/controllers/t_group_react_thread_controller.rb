class TGroupReactThreadController < ApplicationController
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
      data = {
        s_channel_id: session[:s_channel_id],
        s_group_message_id: session[:s_group_message_id],
        thread_id: params[:thread_id],
        user_id: session[:current_user_id],
        emoji: params[:emoji],
      }
      post_data("/groupthreadreact", data)
      redirect_to t_group_message_path(session[:s_group_message_id])
    end
  end
end
