class Admin::ApplicationController < ApplicationController
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      md5_of_password = Digest::MD5.hexdigest(password)
      username == 'admin' && md5_of_password == '819beb9dc2da7311d1aac96151c96c3b'
    end
  end
end
