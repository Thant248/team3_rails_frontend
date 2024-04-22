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

    retrievehome

    render 'show'
  end
end
