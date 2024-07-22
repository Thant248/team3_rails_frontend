class TGroupReactMsgController < ApplicationController
  def create
    if session[:s_channel_id].nil?
      redirect_to home_url
    else
      data = {
        s_channel_id: session[:s_channel_id],
        message_id: params[:message_id],
        user_id: session[:current_user_id],
        emoji: params[:emoji],
      }
      post_data("/groupreact", data)
      redirect_to m_channel_path(session[:s_channel_id])
    end
  end
end
