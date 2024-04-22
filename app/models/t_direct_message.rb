class TDirectMessage 
    include ActiveModel::Model

    attr_accessor :directmsg
    attr_accessor :read_status
    attr_accessor :send_user_id
    attr_accessor :receive_user_id
    attr_accessor :created_at
    attr_accessor :updated_at
    
end
