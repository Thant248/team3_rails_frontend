class DraftListsController < ApplicationController
  def show
    retrievehome
    @current_user_id = @current_user["id"]
    response = get_data("/draftlists?user_id=#{@current_user_id}&workspace_id=#{session[:workspace_id]}")
    if response.nil?
      flash.now[:danger] = 'Null Value'
    else
      @t_direct_messages = response['t_direct_messages'] || []
      @t_direct_threads = response['t_direct_threads'] || []
      @t_group_messages = response['t_group_messages'] || [] 
      @t_group_threads = response['t_group_threads'] || [] 
    end
  end
end