  class MUser
    include ActiveModel::Model

    attr_accessor :id
    attr_accessor :name
    attr_accessor :age
    attr_accessor :email
    attr_accessor :password_digest
    attr_accessor :profile_image
    attr_accessor :remember_digest
    attr_accessor :active_status
    attr_accessor :admin
    attr_accessor :member_status
    attr_accessor :created_at
    attr_accessor :updated_at

  end