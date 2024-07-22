class TDirectReactThreadController < ApplicationController
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
      data = {
        s_direct_message_id: session[:s_direct_message_id],
        s_user_id: session[:s_user_id],
        thread_id: params[:thread_id],
        user_id: session[:current_user_id],
        emoji: params[:emoji],
      }
      post_data("/directthreadreact", data)
      redirect_to t_direct_message_path(session[:s_direct_message_id])
    end
  end
end
