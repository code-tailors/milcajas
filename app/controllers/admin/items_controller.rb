class Admin::ItemsController < Admin::ApplicationController
  respond_to :html, :js

  def index
    @items = Item.page(params[:page])
  end

  def refresh
    Item.destroy_all
    User.all.each do |user|
      begin
        user.reset_items!
      rescue
        user.destroy
      end
    end
    redirect_to action: :index
  end

end
