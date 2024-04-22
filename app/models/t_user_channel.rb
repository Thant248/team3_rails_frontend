class TUserChannel
    include ActiveModel::Model

    attr_accessor :message_count
    attr_accessor :unread_channel_message
    attr_accessor :created_admin
    attr_accessor :userid
    attr_accessor :channelid
    attr_accessor :created_at
    attr_accessor :updated_at
end
