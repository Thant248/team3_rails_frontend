class MWorkspacesController < ApplicationController
  include FaradayApiClient

  def new
  end
  
  def create
    remember_digest = params[:m_user][:remember_digest]
    profile_image = params[:m_user][:profile_image]
    name = params[:m_user][:name]
    email = params[:m_user][:email]
    password = params[:m_user][:password]
    password_confirmation = params[:m_user][:password_confirmation]
    admin = true 

    data = {
      remember_digest: remember_digest,
      profile_image: profile_image,
      name: name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      admin: admin
    }

    result = post_data('/m_users', { m_user: data })

    if result.nil?
      flash.now[:danger] = 'User creation failed'
      render 'new'
    else
      # Check user deactivation status here
      flash.now[:success] = 'User has been successfully created'
      redirect_to signin_path
    end
  end
end
