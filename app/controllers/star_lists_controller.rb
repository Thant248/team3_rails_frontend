class StarListsController < ApplicationController
  include FaradayApiClient
  
  def show
 
    

    current_user_ids = session[:current_user_id]
    response = get_data("/starlists?user_id=#{current_user_ids}")

    # Correct the keys to match the response JSON
    @direct_star = response['direct_Star'] # Corrected
    @direct_star_thread = response['direct_star_thread']  
    @group_star = response['group_star']
    @group_star_thread = response['group_star_thread']

    # Fetch @m_channels from the session
    @m_channels = session[:m_channels]
    @m_p_channels = session[:m_p_channels]
    @m_channelsids = session[:m_channelsids]
    @m_user = session[:m_user]
    

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
