require 'dropbox_sdk'

class DropboxController < ApplicationController

  def refresh
      changes = current_user.dropbox.delta current_user.delta_cursor
      changes["entries"].each do |entry|
        if entry[1].nil?
          item = Item.where(path: entry[0])
          item.delete current_user if item
        else
          unless entry[1]["is_dir"]
            item = Item.create(path: entry[0], size: entry[1]["size"], mime_type: entry[1]["mime_type"] )
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

  end

  def upload
    # Check if user has no dropbox session...re-direct them to authorize
    return redirect_to(:action => 'authorize') unless session[:dropbox_session]

    dbsession = DropboxSession.deserialize(session[:dropbox_session])
    client = DropboxClient.new(dbsession, ACCESS_TYPE) #raise an exception if session not authorized
    info = client.account_info # look up account information

    if request.method != "POST"
      # show a file upload page
      render :inline =>
        "#{info['email']} <br/><%= form_tag({:action => :upload}, :multipart => true) do %><%= file_field_tag 'file' %><%= submit_tag %><% end %>"
      return
    else
      # upload the posted file to dropbox keeping the same name
      resp = client.put_file(params[:file].original_filename, params[:file].read)
      render :text => "Upload successful! File now at #{resp['path']}"
    end
  end
end

# def authorize
#   if not params[:oauth_token]
#     dbsession = get_dropbox_session

#     session[:dropbox_session] = dbsession.serialize #serialize and save this DropboxSession

#     #pass to get_authorize_url a callback url that will return the user here
#     redirect_to dbsession.get_authorize_url url_for(:action => 'authorize')
#   else
#     # the user has returned from Dropbox
#     dbsession = DropboxSession.deserialize(session[:dropbox_session])
#     dbsession.get_access_token  #we've been authorized, so now request an access_token
#     session[:dropbox_session] = dbsession.serialize

#     redirect_to :action => 'upload'
#   end
# end
