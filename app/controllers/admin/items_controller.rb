class Admin::ItemsController < Admin::ApplicationController
  respond_to :html, :js

  def index
    @items = Item.page(params[:page])
  end

end