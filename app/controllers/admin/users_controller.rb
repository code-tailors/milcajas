class Admin::UsersController < Admin::ApplicationController

  def show
    @user = User.find params[:id]
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to action: :index, notice: t('user.destroyed')
  end

  def index
    @user = User.all
  end

  def refresh
    User.all.each do |user|
      begin
        user.dropbox.account_info
      rescue
        user.destroy
      end

      user.refresh_items
    end
    redirect_to controller: "admin/items", action: :index
  end

  def block
    @user = User.find params[:id]
    @user.block!
    redirect_to action: :index, notice: t('user.blocked')
  end

end
