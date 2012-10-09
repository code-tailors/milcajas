class UsersController < ApplicationController

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:notice]="Usuario eliminado"
  end
end