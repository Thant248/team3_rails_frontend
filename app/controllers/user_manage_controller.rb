#Slack System
#Direct Message Controller 
#Authorname-NyiNyiMinThant@CyberMissions Myanmar Company limited 
#@Since 27/06/2019
#Version 1.0.0

class UserManageController < ApplicationController
  def usermanage
    #check unlogin user
    # checkuser

    session.delete(:s_user_id)
    session.delete(:s_channel_id)
    session.delete(:s_direct_message_id)
    session.delete(:s_group_message_id)
    session.delete(:r_direct_size)
    session.delete(:r_group_size)

    response = get_data('/usermanage')
    @user_manages_activate = response['user_manages_activate']
    @user_manages_deactivate = response['user_manages_deactivate']
    @user_manages_admin = response['user_manages_admin']



    #call from ApplicationController for retrieve home data
    retrievehome
  end

  def edit
    MUser.where(id: params[:id]).update_all(member_status: 0)
    redirect_to action:"usermanage"
  end

  def update
    MUser.where(id: params[:id]).update_all(member_status: 1)
    redirect_to action:"usermanage"
  end
end
