class AllUnreadController < ApplicationController
    def show
    

        response = get_data("/allunread?user_id=#{@user_id}")
        if response.nil?
            flash.now[:danger] = 'Null Value'
        else 
            @t_direct_messages = response['t_direct_messages'] || []
            @t_direct_threads = response['t_direct_threads'] || []
            @t_user_channelids = response['t_user_channelids'] || []
            @t_group_messages = response['t_group_messages'] || []  

            retrievehome
        end
    end
end

       