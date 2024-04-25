class MentionListsController < ApplicationController
  include FaradayApiClient
  def show
    #check login user
   

    current_user_id = session[:current_user_id]
    response = get_data("/mentionlists?user_id=#{current_user_id}")
    @t_group_messages = response['t_group_messages']
    @t_group_threads = response['t_group_threads']
    @t_group_star_msgids = response['t_group_star_msgids']
    @t_group_star_thread_msgids = response['t_group_star_thread_msgids']
    retrievehome
    # render 'show'

  end
end
