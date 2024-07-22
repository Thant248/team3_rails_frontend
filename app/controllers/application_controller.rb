class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include FaradayApiClient
  include SessionsHelper

  def retrievehome
    response = get_data("/main")

    @m_channels = MChannel.new

    @current_user = response["current_user"]
    @m_usering = MUser.new(@current_user)
    @email = @m_usering.email
    @m_user = @current_user["name"]
    @current_user_id = @current_user["id"]
    @profile_image_url = @current_user["profile_image_url"]

    @current_user_admin = @current_user["admin"]
    @workspace_name = response["m_workspace"]["workspace_name"]
    @workspace_id = response["m_workspace"]["id"]
    # Add more instance variables if needed
    @m_users = response["m_users"]
    @m_channels = response["m_channels"]
    @m_p_channels = response["m_p_channels"]
    @direct_msgcounts = response["direct_msgcounts"]
    @all_unread_count = response["all_unread_count"]
    @m_channelsids = response["m_channelsids"]
    @direct_draft_status_counts = response["direct_draft_status_counts"]
    @group_draft_status_counts = response["group_draft_status_counts"]

    session[:current_user_id] = @current_user_id
    session[:m_channels] = response["m_channels"]
    session[:m_user_email] = @current_user["email"]
    # session[:m_users] = response["m_users"]
    # session[:m_p_channels] = response["m_p_channels"]
    # session[:m_channelsids] = response["m_channelsids"]
    session[:m_user] = @current_user["name"]
    session[:workspace_id] = @workspace_id
  end

  def retrieve_direct_message
    response = get_data("/m_users/#{session[:s_user_id]}")
    @s_user = response["s_user"]
    @t_direct_messages = response["t_direct_messages"]
    @temp_direct_star_msgids = response["temp_direct_star_msgids"]
    @t_direct_star_msgids = response["t_direct_star_msgids"]
    @t_direct_message_dates = response["t_direct_message_dates"].sort_by { |e| e["created_date"] } || []
    @t_direct_message_datesize = response["t_direct_message_datesize"]
    @t_direct_react_msgids = response["t_direct_react_msgids"] || []
    @t_direct_msg_emojiscounts = response["t_direct_msg_emojiscounts"] || []
    @react_usernames = response["react_usernames"] || []
  end

  def retrieve_direct_thread
    response = get_data("/directhread/#{session[:s_direct_message_id]}")
    @s_user = response["s_user"]
    @t_direct_message = response["t_direct_message"]
    @t_direct_threads = response["t_direct_threads"]
    @t_direct_star_thread_msgids = response["t_direct_star_thread_msgids"]
    @sender_name = response["sender_name"]
    @send_user = response['send_user']
    @t_direct_react_thread_msgids = response["t_direct_react_thread_msgids"] || []
    @t_direct_thread_emojiscounts = response["t_direct_thread_emojiscounts"] || []
    @react_usernames = response["react_usernames"] || []
  end

  def retrieve_group_message
    response = get_data("/m_channels/#{session[:s_channel_id]}")

    @s_channel = response["retrieve_group_message"]["s_channel"]
    @m_channel_users = response["retrieve_group_message"]["m_channel_users"]
    @length = @m_channel_users.length
    @t_group_messages = response["retrieve_group_message"]["t_group_messages"]
    @t_group_star_msgids = response["retrieve_group_message"]["t_group_star_msgids"]
    @u_count = response["retrieve_group_message"]["u_count"]
    @created_admin = response["retrieve_group_message"]["created_admin"]
    @t_group_message_dates = response["retrieve_group_message"]["t_group_message_dates"].sort_by { |e| e["created_date"] } || []
    @t_group_message_datesize = response["retrieve_group_message"]["t_group_message_datesize"] || []
    @t_group_react_msgids = response["retrieve_group_message"]["t_group_react_msgids"]
    @emoji_counts = response["retrieve_group_message"]["emoji_counts"]
    @react_usernames = response["retrieve_group_message"]["react_usernames"]
  end

  def retrieve_group_thread
    response = get_data("/t_group_messages/#{session[:s_group_message_id]}?s_channel_id=#{session[:s_channel_id]}")
    @s_channel = response["retrieveGroupThread"]["s_channel"]
    @m_channel_users = response["retrieveGroupThread"]["m_channel_users"]
    @t_group_message = response["retrieveGroupThread"]["t_group_message"]
    @send_user = response["retrieveGroupThread"]["send_user"]
    @t_group_threads = response["retrieveGroupThread"]["t_group_threads"]
    @temp_group_star_thread_msgids = response["retrieveGroupThread"]["temp_group_star_thread_msgids"]
    @t_group_star_thread_msgids = response["retrieveGroupThread"]["t_group_star_thread_msgids"]
    @u_count = response["retrieveGroupThread"]["u_count"]
    @t_group_react_thread_msgids = response["retrieveGroupThread"]["t_group_react_thread_msgids"]
    @emoji_counts = response["retrieveGroupThread"]["emoji_counts"]
    @react_usernames = response["retrieveGroupThread"]["react_usernames"]
  end

  def checkuser
    if session[:workspace_id].nil?
      redirect_to home_url
    else
      # m_user = MUser.find_by(id: session[:user_id], member_status: 1)
      m_user = session[:current_user_id]
      if m_user.nil?
        session.delete(:workspace_id)
        session.delete(:s_channel_id)
        session.delete(:s_user_id)
        session.delete(:s_direct_message_id)
        session.delete(:s_group_message_id)

        flash.clear
        # log_out if logged_in?
        # ログアウト用のAPIをCALLする
        redirect_to home_url
      end
    end
  end

  def checkloginuser
    unless session[:workspace_id].nil?
      redirect_to home_url
    end
  end
end
