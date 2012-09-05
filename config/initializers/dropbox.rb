APP_KEY = "ctneuigl2zz6urw"
APP_SECRET = "cq93sx2x5b7eapc"
ACCESS_TYPE = :app_folder #The two valid values here are :app_folder and :dropbox
#The default is :app_folder, but your application might be
#set to have full :dropbox access.  Check your app at
#https://www.dropbox.com/developers/apps

# class DropboxSession
#       def format_path(path, escape=true) # :nodoc:
#         path = path.gsub(/\/+/,"/")
#         # replace multiple slashes with a single one
#         path = path.gsub(/^\/?/,"/")
#         # ensure the path starts with a slash
#         path.gsub(/\/?$/,"")
#         # ensure the path doesn't end with a slash
#         #return URI.escape(path, RESERVED_CHARACTERS) if escape
#         #path= URI.escape(path)#, RESERVED_CHARACTERS) if escape
#         debugger
#         path
#     end

# end
