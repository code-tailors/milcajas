require 'dropbox_sdk'

class DropboxController < ApplicationController

  def reset
    current_user.update_attribute(:delta_cursor, nil)
    current_user.items.delete_all
    redirect_to action: :refresh
  end

  def refresh
      changes = current_user.dropbox.delta current_user.delta_cursor
      changes["entries"].each do |entry|
        if entry[1].nil?
          item = Item.where(path: entry[0])
          item.delete current_user if item
        else
          unless entry[1]["is_dir"]
            path = entry[0]
            name = path.split("/").last
            item = Item.create(name: name, path: path, size: entry[1]["size"], mime_type: entry[1]["mime_type"] )
            item.users << current_user
          end
        end
      end
      current_user.update_attribute(:delta_cursor, changes["cursor"])

      redirect_to action: :show
  end

  def show
    @items = Item.all
  end

  def copy
    item = Item.find params[:id]
    from_user_db = item.users.first.dropbox
    copy_ref = from_user_db.create_copy_ref(item.path)['copy_ref']
    current_user.dropbox.add_copy_ref(item.name, copy_ref)
    head :ok
  end

end
