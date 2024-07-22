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
    old_password = params[:m_user][:old_password]
    password = params[:m_user][:password]
    password_confirmation = params[:m_user][:password_confirmation]
    data = {
      "m_user": {
      "old_password": old_password,
      "password": password,
      "password_confirmation": password_confirmation
      }
    }
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
      connection = Faraday.new(url: 'http://localhost:3000/') do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.request :authorization, 'Bearer', -> { auth_token }
      end
      response = connection.put("m_users/#{session[:current_user_id]}", data)
      response_data = JSON.parse(response.body)
      if response.status == 200 &&  response_data["error"].nil?
        flash[:success] = 'password has been successfully changed.'
        redirect_to home_path
      else
        flash[:danger] =  response_data["error"]
        redirect_to change_password_url(id: session[:current_user_id])
      end
    end
  end

  def profile_upload
    user_id = params[:user_id]
    image_data = params[:image][:data]
    mime_type = params[:image][:mime]

    data = {
      "user_id": user_id,
      "image": {
        "data": image_data,
        "mime": mime_type
      }
    }

    result = post_data("/profile_update", data)

    if result.nil?
      flash.now[:danger] = 'Profile upload failed'
      render json: { success: false, message: 'Profile update failed' }
    else
      retrievehome
      flash.now[:success] = 'Profile has been successfully uploaded'
      render json: { success: true, message: 'Profile has been successfully uploaded' }
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

  def edituser
    retrievehome
  end

  def updateuser
    retrievehome
    data = {
      "username": params[:m_user][:username]
    }
    connection = Faraday.new(url: 'http://localhost:3000/') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.request :authorization, 'Bearer', -> { auth_token }
    end
    response = connection.patch("m_users/edit_username", data)
    responseData = JSON.parse(response.body)
    if response.status == 200
      flash[:success] = 'User name has been successfully changed'
      # update user name in session
      session[:m_user] = params[:m_user][:username]

      redirect_to home_path
    else
      flash[:danger] =  ".User name "+responseData["error_message"]["name"].join(" and ")
      render :edituser, status: :unprocessable_entity
    end
  end
end