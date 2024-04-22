class ThreadController < ApplicationController
    def show 
      
        response1 = get_data('/main')
       if response1.nil?
          flash.now[:danger] = 'Null value'
       else
        @current_user = response1['current_user']
        @user_id = @current_user['id']
        @m_user = @current_user["name"]
        @workspace_name = response1["m_workspace"]["workspace_name"]
    
        # Add more instance variables if needed
        @m_users = response1["m_users"] || []
        @m_channels = response1["m_channels"] || []
        @m_p_channels = response1["m_p_channels"] || []
        @direct_msgcounts = response1["direct_msgcounts"]
        @all_unread_count = response1["all_unread_count"]
        @m_channelsids = response1["m_channelsids"]
       end
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
    end
end

