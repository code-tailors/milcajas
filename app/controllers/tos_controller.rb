class TosController < ApplicationController

  def new
  end

  def create
    if params[:accept]
      current_user.update_attribute(:tos, true)
      redirect_to items_path
    else
      flash.now[:error]=t("views.tos.must_accept")
      render :new
    end
  end

end
