class SessionsController < ApplicationController

  def new
    dbsession = get_dropbox_session
    redirect_to "/auth/dropbox"
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    unless user.tos
      redirect_to new_tos_path, notice: "Signed in!"
    else
      redirect_to refresh_items_url, notice: "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
