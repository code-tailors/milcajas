class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def reset
    current_user.reset_items
    redirect_to action: :show
  end

  def refresh
    current_user.refresh_items
    redirect_to action: :show
  end

  def show
    @items = Item.uniques
  end

  def copy
    item = Item.find params[:id]
    from_user_db = item.user.dropbox
    copy_ref = from_user_db.create_copy_ref(item.path)['copy_ref']
    current_user.dropbox.add_copy_ref(item.name, copy_ref)
    head :ok
  end

  private
  def authenticate_user!
    redirect_to root_path unless session[:user_id]
  end

end
