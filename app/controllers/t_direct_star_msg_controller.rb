class TDirectStarMsgController < ApplicationController
  def create
    #check unlogin user
    # checkuser

    if session[:s_user_id].nil?
      redirect_to home_url
    else
      get_data("/star?s_user_id=#{session[:s_user_id]}&id=#{params[:id]}&user_id=#{session[:current_user_id]}")
      redirect_to m_user_path(session[:s_user_id])
    end
  end

  def destroy
    #check unlogin user
    # checkuser

    if session[:s_user_id].nil?
      redirect_to home_url
    else
      get_data("/unstar?id=#{params[:id]}")
      redirect_to m_user_path(session[:s_user_id])
    end
  end
end
