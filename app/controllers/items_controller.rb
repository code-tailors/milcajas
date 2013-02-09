class ItemsController < ApplicationController
  REFRESH_THRESHOLD = 600

  before_filter :authenticate_user!
  respond_to :html
  respond_to :js, :only => [:index, :update, :copy]

  def reset
    current_user.reset_items
    redirect_to action: :index
  end

  def refresh
    refresh_items!(true)
    redirect_to action: :index
  end

  def index
    refresh_items!
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
    begin
      DropboxService.copy(params[:id], current_user)
    rescue DropboxService::ItemNotFound
      logger.info "[Copy] Item not found"
      flash[:notice]=t("views.items.exists")
    rescue DropboxError => db_error
      Airbrake.notify(db_error)
      logger.error "[Copy] #{e.message} #{e.backtrace.join("\n")[0..20]}"
      if db_error.message.include?"already exists"
        flash[:notice]=t("views.items.exists")
      else
        flash[:notice]=t("views.items.copy_fail")
      end
    rescue => e
      Airbrake.notify(
           e,
           :parameters    => params
        )
      logger.error "[Copy] #{e.message} #{e.backtrace.join("\n")[0..20]}"
      flash[:notice]=t("views.items.copy_fail")
    end
   
    flash[:notice]=t("views.items.copied")
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
    flash.now[:notice]="File denounced!"
    @item.denounce!(current_user.id)
  end

  private

  def refresh_items!(force=false)
    if session[:refresh_at] 
     if session[:refresh_at] - Time.now.to_i - REFRESH_THRESHOLD
      current_user.refresh_items
      session[:refresh_at]=Time.now.to_i
     end
    else
      current_user.refresh_items
      session[:refresh_at]=Time.now.to_i
    end
  end

end
