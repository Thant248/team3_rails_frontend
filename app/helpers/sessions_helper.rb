module SessionsHelper

  def log_in(auth)
    session[:user_id] = auth['m_user_id']
    session[:workspace_id] = auth['workspace_id']
    session[:token] = auth['token']
    # RedisClient.redis.set("#{auth['m_user_id']}_token", auth['token'])
    # sample
    # sample_data = MUser.new({id: auth['m_user_id'], name: 'テスト名前2'})
    # RedisClient.redis.set(auth['m_user_id'], Marshal.dump(sample_data))
  end

  def current_user?(m_user)
    m_user == current_user
  end

  def current_user
    user_id = session[:user_id]
     @current_user ||= MUser.find_by(id: user_id)
    # data = RedisClient.redis.get(user_id)
    @current_user ||= Marshal.load(data)
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    # session.delete(:s_user_id)
    # session.delete(:workspace_id)
    # session.delete(:s_channel_id)
    @current_user = nil
    # Clear redis
    # RedisClient.redis.del(
    #   "#{session[:user_id]}_token", 
    #   session[:user_id]
    # )
    session.delete(:user_id)
    session.delete(:workspace_id)
    session.delete(:token)
    
    redirect_to root_url
  end

  def auth_token
     session[:token]
    # RedisClient.redis.get("#{current_user_id}_token")
  end

  def current_user_id
    current_user.id
  end
end
