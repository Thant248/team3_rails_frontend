class MentionListsController < ApplicationController
  def show
    #check login user
    #checkuser
    current_user_id = session[:current_user_id]
    response = get_data("/mentionlists?user_id=#{current_user_id}")
    @t_group_messages = response['t_group_messages']
    @t_group_threads = response['t_group_threads']
    @t_group_star_msgids = response['t_group_star_msgids']
    @t_group_star_thread_msgids = response['t_group_star_thread_msgids']

    responses =  get_data('/main')

    @current_user = responses["current_user"]
    @m_user = @current_user["name"]
    @current_user_id = @current_user["id"]
    @current_user_admin = @current_user["admin"]
    @workspace_name = responses["m_workspace"]["workspace_name"]

    # Add more instance variables if needed
    @m_users = responses["m_users"]
    @m_channels = responses["m_channels"]
    @m_p_channels = responses["m_p_channels"]
    @direct_msgcounts = responses["direct_msgcounts"]
    @all_unread_count = responses["all_unread_count"]
    @m_channelsids = responses["m_channelsids"]

    render 'show'

  end
end
