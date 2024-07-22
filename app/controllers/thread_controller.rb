class ThreadController < ApplicationController
  include FaradayApiClient

  def show
    session.delete(:s_user_id)
    session.delete(:s_channel_id)
    session.delete(:s_direct_message_id)
    session.delete(:s_group_message_id)
    session.delete(:r_direct_size)
    session.delete(:r_group_size)

    response1 = get_data('/main')
    @current_user = response1['current_user']
    @user_id = @current_user['id']
    response = get_data("/thread?user_id=#{@user_id}")
    if response.nil?
        flash.now[:danger] = 'Null value'
    else
      @t_direct_messages = response['t_direct_messages'] || []
      @t_direct_threads = response['t_direct_threads'] || []
      @t_group_messages = response['t_group_messages'] || []
      @t_group_threads = response['t_group_threads'] || []
      @t_direct_star_thread_msgids = response['t_direct_star_thread_msgids'] || []
      @t_direct_star_msgids = response['t_direct_star_msgids'] || []
      @t_group_star_msgids = response['t_group_star_msgids'] || []
      @t_group_star_thread_msgids = response['t_group_star_thread_msgids'] || []
    end

    retrievehome
  end
end
