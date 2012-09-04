module DropboxHelper


  def show_metadata(db_client, entry)
    if entry['is_dir']
      render_folder(db_client, entry)
    else
      render_file(db_client, entry)
    end
  end

  def render_folder(db_client, entry)
    # Provide an upload form (so the user can add files to this folder)
    out = "<form action='/upload' method='post' enctype='multipart/form-data'>"
    out += "<label for='file'>Upload file:</label> <input name='file' type='file'/>"
    out += "<input type='submit' value='Upload'/>"
    out += "<input name='folder' type='hidden' value='#{h entry['path']}'/>"
    out += "</form>"  # TODO: Add a token to counter CSRF attacks.
    # List of folder contents
    entry['contents'].each do |child|
      cp = child['path']      # child path
      cn = File.basename(cp)  # child name
      if (child['is_dir']) then cn += '/' end
      out += "<div><a style='text-decoration: none' href='/?path=#{h cp}'>#{h cn}</a></div>"
    end

     "Folder: #{entry['path']} #{out}"
  end

  def render_file(db_client, entry)
    "File: #{entry['path']} <pre>#{h entry.pretty_inspect}</pre>"
  end

end
