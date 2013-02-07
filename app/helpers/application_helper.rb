module ApplicationHelper

  def render_flash(flash)
    to_render = ""
    flash.each do |key, value|
       to_render += render partial: "layouts/flash", locals: {key: key, value: value}
    end 
    to_render.html_safe
  end

end
