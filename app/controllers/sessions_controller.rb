class SessionsController < ApplicationController


  def new
    dbsession = DropboxSession.new APP_KEY, APP_SECRET
    dbsession.get_request_token
    debugger
    dbsession.get_access_token
    if dbsession.authorized?
      redirect_to refresh_dropbox_url, notice: "Signed in!"
    else
      redirect_to "/auth/dropbox"
    end
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to refresh_dropbox_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
