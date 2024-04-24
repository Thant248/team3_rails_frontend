#Slack System
#Direct Message Controller 
#Authorname-MyoMinNaing@CyberMissions Myanmar Company limited 
#@Since 27/06/2019
#Version 1.0.0

class MemberInvitationController < ApplicationController
  include FaradayApiClient
  
  def new
    #check unlogin user
    checkuser
    
    retrievehome
    @m_channels ||= []
  end


  def invite
    #check unlogin user
    # checkuser
    retrievehome
    email = params[:session][:email]
    channel_id = params[:session][:channel_id][1] # Corrected typo here
  
    data = {
      "email": email,
      "channel_id": channel_id,
      "workspace_id": session[:workspace_id]
    }
  
    result = post_data("/memberinvite", {m_invite: data})
    if result.nil?
      flash.now[:danger] = 'Member invite failed'
      redirect_to memberinvite_url
    else
      flash.now[:success] = 'Member has been successfully invited'
      redirect_to home_url
    end
  end
end
