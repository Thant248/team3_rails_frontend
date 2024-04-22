# app/services/faraday_api_client.rb

require 'faraday'

module FaradayApiClient
  include SessionsHelper

  #　認証前
  def make_login(path, data = {})
    response = guest_conn.post(path) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = data.to_json
    end

    handle_response(response)
  end

  #　認証後
  def make_logut(path)
    response = auth_conn.get(path) do |request|
      request.headers['Content-Type'] = 'application/json'
    end

    handle_response(response)
  end


  def get_data(path, params = {})
    response = auth_conn.get(path) do |request|
      request.params.merge!(params)
    end

    handle_response(response)
  end

  def post_data(path, data = {})
    response = auth_conn.post(path) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.body = data.to_json
    end

    handle_response(response)
  end

  def delete_data(path, data = {})
  end

  def put_data(path, data = {})
  end

  private

  def guest_conn
    @faraday ||= Faraday.new(url: 'https://cmmteam3-backend-api.onrender.com') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def auth_conn
    @faraday ||= Faraday.new(url: 'https://cmmteam3-backend-api.onrender.com') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.request :authorization, 'Bearer', -> { auth_token }
    end
  end

  def handle_response(response)
    # logger.debug '#########RESPONSE######'
    # logger.debug response
    if response.success?
      JSON.parse(response.body)
    else
      # raise "アクセスに失敗されました。: #{response.status}"
    end
  end
end
