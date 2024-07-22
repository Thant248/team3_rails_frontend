class TDirectReactMsgController < ApplicationController
  def create
    #check unlogin user
    # checkuser

    if session[:s_user_id].nil?
      redirect_to home_url
    else
      data = {
        s_user_id: session[:s_user_id],
        message_id: params[:message_id],
        user_id: session[:current_user_id],
        emoji: params[:emoji],
      }
      post_data("/directreact", data)
      redirect_to m_user_path(session[:s_user_id])
    end
  end
end
