class ItemsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html
  respond_to :js, :only => [:index, :update, :copy]

  def reset
    current_user.reset_items
    redirect_to action: :index
  end

  def refresh
    current_user.refresh_items
    redirect_to action: :index
  end

  def index
        flash[:notice]="hola chabon como va"
    #@yours = current_user.items.uniques
    if not params[:query].blank? and query = params[:query]
      @others = Item.text_search(query,params[:page],50)
      logger.debug "Results: #{@others.size}"
    else
      @others = Item.uniques.page(params[:page]) #- @yours
    end
      @categories = Category.all
  end

  def copy
    item = Item.find params[:id]
    from_user_db = item.user.dropbox
    copy_ref = from_user_db.create_copy_ref(item.path)['copy_ref']
    current_user.dropbox.add_copy_ref(item.name, copy_ref)
    head :ok
  end

  #TODO: Chequear propiedad del item antes de actualizar
  def update
    @item = Item.find params[:id]
    if @item.update_attributes(params[:item])
      @categories = Category.all
      respond_with(@item)
    else
      head :bad_request
    end
  end

  def denounce
    @item = Item.find params[:id]
    @item.denounce!
  end


end
