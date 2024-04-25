class MChannelsController < ApplicationController
  include FaradayApiClient
  def new
      #check unlogin user
      
  
      session.delete(:s_user_id)
      session.delete(:s_channel_id)
      session.delete(:s_direct_message_id)
      session.delete(:s_group_message_id)
      
     
      retrievehome
  end

   def refresh_group
   

    if session[:r_group_size].nil?
      session[:r_group_size] =  10
    else
      session[:r_group_size] +=  10
    end

    #call from ApplicationController for retrieve group message data
    retrieve_group_message

    #call from ApplicationController for retrieve home data
    retrievehome
   end

    def create
      #check unlogin user
       
  
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
          post_data('/m_channels',{m_channel: data})
          redirect_to home_url   
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

    def edit
      @m_channel =  session[:s_channel_id]
        #call from ApplicationController for retrieve home data
        retrievehome 
    end

    def update
     

      channel_status = params[:session][:channel_status]
      channel_name = params[:session][:channel_name]
          data = {
            "channel_status": channel_status ,
            "channel_name": channel_name ,
            "m_workspace_id": session[:workspace_id]
        }
        post_data("/channelupdate?id=#{session[:s_channel_id]}",{m_channel: data})
        
        redirect_to m_channel_path(session[:s_channel_id])
        
      
    end

    def delete
      

      channel_id =  session[:s_channel_id]
       delete_data("/m_channels/#{channel_id}")
        redirect_to home_url 
    end

  
end