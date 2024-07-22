class StaticPagesController < ApplicationController
  include FaradayApiClient
  # before_action :check_user

  def welcome
  end

  def home
    session.delete(:s_user_id)
    session.delete(:s_channel_id)
    session.delete(:s_direct_message_id)
    session.delete(:s_group_message_id)
    session.delete(:r_direct_size)
    session.delete(:r_group_size)

    # ここに必要なデータをAPIから取得する
    retrievehome
  end
end
