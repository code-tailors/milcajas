class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:user_id)
      return false
    end
  end
  helper_method :current_user

  def get_dropbox_session
    $db_session ||= DropboxSession.new(ENV['APP_KEY'], ENV['APP_SECRET'])
  end

  private
  def authenticate_user!
    redirect_to root_path unless session[:user_id]
  end


end
