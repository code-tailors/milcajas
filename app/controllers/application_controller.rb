class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

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

  def set_locale
    I18n.locale = extract_locale_from_subdomain || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.include?(parsed_locale.try(:to_sym) ) ? parsed_locale : nil
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
