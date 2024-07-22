class TDirectMessagesController < ApplicationController
  include FaradayApiClient
  
  def show
    #check unlogin user
    # checkuser

    session[:s_direct_message_id] =  params[:id]

    #call from ApplicationController for retrieve direct thread data
    retrieve_direct_thread

    #call from ApplicationController for retrieve home data
    retrievehome
  end
end
