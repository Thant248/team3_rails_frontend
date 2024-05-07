class AllUnreadController < ApplicationController
    def show
        retrievehome
        @current_user_id = @current_user["id"]
        response = get_data("/allunread?user_id=#{@current_user_id}")
        if response.nil?
            flash.now[:danger] = 'Null Value'
        else 
            @t_direct_messages = response['t_direct_messages'] || []
            @t_direct_threads = response['t_direct_threads'] || []
            @t_user_channelids = response['t_user_channelids'] || []
            @t_group_messages = response['t_group_messages'] || []  
            puts '============================='
            puts @t_direct_messages
            puts '============================='
            
        end
    end
end

       