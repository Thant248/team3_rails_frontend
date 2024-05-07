#Slack System
#Direct Message Controller 
#@Since 27/06/2019
#Version 1.0.0

class MUsersController < ApplicationController
  
  include FaradayApiClient
 
  def create
      workspaceid = session[:confirm_workspace_id]
      workSpaceName = session[:cofirm_ws_name]
      channelName = session[:confirm_cs_name]
      email = session[:confirm_email]
      name = params[:m_user][:name]
      password = params[:m_user][:password]
      password_confirmation = params[:password_confirmation]

      data = {
        "m_user": {
    "remember_digest": workSpaceName,
    "profile_image": channelName,
    "name": name,
    "email": email,
    "password": password,
    "password_confirmation": password_confirmation,
    "admin": false
  },
  "workspace_id": {"invite_workspaceid": workspaceid}
      }
      result = post_data("/confirm_login", data)

      if result.nil?
        flash.now[:danger] = 'User creation failed'
        render 'confirm'
      else
        # Check user deactivation status here
        flash.now[:success] = 'User has been successfully created'
        redirect_to signin_path
      end
  end

  def update
    #check unlogin user
    # checkuser

    password = params[:m_user][:password]
    password_confirmation = params[:m_user][:password_confirmation]

    if password == "" || password.nil?
      flash[:danger] = "Password can't be blank."
      redirect_to change_password_url(id: session[:current_user_id])
    elsif password_confirmation == "" || password_confirmation.nil?
      flash[:danger] = "Confirm Password can't be blank."
      redirect_to change_password_url(id: session[:current_user_id])
    elsif password != password_confirmation
      flash[:danger] = "Password and Confirmation Password does not match."
      redirect_to change_password_url(id: session[:current_user_id])
    else 
      data = {
        "password": password,
        "password_confirmation": password_confirmation
      }
      
      put_data("/m_users/#{session[:current_user_id]}", {m_user: data})
      flash[:success] = "Change Password Successful."
      redirect_to home_url
    end
  end
  
  def confirm
    #check login user
    # checkloginuser

     @m_workspace =  params[:workspaceid]
     session[:confirm_workspace_id] = params[:workspaceid]
     @m_channel = params[:channelid]
     @email = params[:email]
     response = get_data("confirminvitation?workspaceid=#{@m_workspace}&channelid=#{@m_channel}&email=#{@email}")
     @m_user = MUser.new 
     @m_user.email = response['m_user']['email']
     @m_user.remember_digest = response['m_user']['remember_digest']
     @m_user.profile_image = response['m_user']['profile_image']

     session[:cofirm_ws_name] = @m_user.remember_digest
     session[:confirm_cs_name] = @m_user.profile_image
     session[:confirm_email] = @m_user.email
    # session[:invite_workspaceid] = params[:workspaceid]

    # @m_user = MUser.new
    
    # @m_user.remember_digest = @m_workspace.workspace_name
    # @m_user.profile_image = @m_channel.channel_name
  end


  

  def show
    #check unlogin user
  

    session.delete(:s_channel_id)
    session.delete(:s_group_message_id)
    session.delete(:s_direct_message_id)
    session.delete(:r_group_size)
    
    session[:s_user_id] =  params[:id]

    session[:r_direct_size] =  10

    @m_users = params[:id]
    #call from ApplicationController for retrieve direct message data
    retrieve_direct_message

    #call from ApplicationController for retrieve home data
    retrievehome
  end

  #Authorname-KyawSanWin@CyberMissions Myanmar Company limited 
  def refresh_direct
    #check unlogin user
     checkuser

    if session[:r_direct_size].nil?
      session[:r_direct_size] =  10
    else
      session[:r_direct_size] +=  10
    end

    #call from ApplicationController for retrieve direct message data
    retrieve_direct_message

    #call from ApplicationController for retrieve home data
    retrievehome
  end
end