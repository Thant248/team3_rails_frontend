class AllUnreadController < ApplicationController
    def show

        response1 = get_data('/main')
        if response1.nil?
            flash.now[:danger] = 'Null Value'
        else
            @current_user = response1["current_user"]
            @m_user = @current_user["name"]
            @current_user_id = @current_user["id"]
            @current_user_admin = @current_user["admin"]
            @workspace_name = response1["m_workspace"]["workspace_name"]

            # Add more instance variables if needed
            @m_users = response1["m_users"]
            @m_channels = response1["m_channels"]
            @m_p_channels = response1["m_p_channels"]
            @direct_msgcounts = response1["direct_msgcounts"]
            @all_unread_count = response1["all_unread_count"]
            @m_channelsids = response1["m_channelsids"]
        end
        response = get_data("/allunread?user_id=#{@user_id}")
        if response.nil?
            flash.now[:danger] = 'Null Value'
        else 
            @t_direct_messages = response['t_direct_messages'] || []
            @t_direct_threads = response['t_direct_threads'] || []
            @t_user_channelids = response['t_user_channelids'] || []
            @t_group_messages = response['t_group_messages'] || []  
        end
    end
end

       