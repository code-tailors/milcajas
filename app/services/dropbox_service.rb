module DropboxService
  extend self

  #TODO: this should do the replacement find and raise different errors
  def copy(item_id, target_user)
    item = find_item(item_id)

    if item
      Rails.logger.info "[DroboxService#copy] #{item.path} from #{item.user.uid}"
      from_user_db = item.user.dropbox
      Rails.logger.debug "[DroboxService#copy] Item belongs to #{from_user_db.account_info}"
      copy_ref = from_user_db.create_copy_ref(item.path)['copy_ref']
      response = target_user.dropbox.add_copy_ref(item.name, copy_ref)
      Rails.logger "[DroboxService#copy] #{response}"
    end
    true
  end

  def find_item(item_id)
    item = Item.find item_id
    if item && item.user 
      item 
    elsif item  
      items = Item.where("path = ?", item.path)
      begin
        item.destroy #Remove from database given it doesn't have a user
        item = items.pop
        break unless item
      end until item.user

      raise ItemNotFound unless item && item.user
    else
      raise ItemNotFound
    end
     
    item
  end

   class ItemNotFound < Exception
   end

end

