class MChannelsController < ApplicationController
    def new
        #check unlogin user
        # checkuser
    
        session.delete(:s_user_id)
        session.delete(:s_channel_id)
        session.delete(:s_direct_message_id)
        session.delete(:s_group_message_id)
        
       
        retrievehome
      end
      def create
        #check unlogin user
        # checkuser
    
        #call from ApplicationController for retrieve home data
        retrievehome
    
        if params[:session][:channel_name].nil? || params[:session][:channel_name] == ""
          flash[:danger] = "Channel Name can't be blank."
          render 'm_channels/new'
        else
            data = {
                "user_id": session[:current_user_id],
                "channel_status": params[:session][:channel_status],
                "channel_name": params[:session][:channel_name],
                "m_workspace_id": session[:workspace_id]
            }
            response = post_data('/m_channels',{m_channel: data})

            if response.code.to_i == 200 
              flash[:success] = "Channel created successfully."
              redirect_to home_url 
            end
           
        end
      end

      def show
        session.delete(:s_user_id)
        session.delete(:s_direct_message_id)
        session.delete(:s_group_message_id)
        session.delete(:r_direct_size)
  
        session[:s_channel_id] =  params[:id]
  
        session[:r_group_size] = 10
        retrieve_group_message

        retrievehome
      end

end