# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper

  def textilize(text)
    Textilizer.new(text).to_html unless text.blank?
  end

  def tab_class(section)
    case section
      when "posts"
        {:class => 'selected'} if controller_name == section && action_name != 'new'
      when "new_post"
        {:class => 'selected'} if controller_name == "posts" && action_name == 'new'
      when "contacts"
        {:class => 'selected'} if controller_name == section && action_name != 'new'
    end
  end

  def flash_message
    if !flash[:notice].blank? 
      "<div class='message ok'>" + flash[:notice] + "</div>" 
    elsif !flash[:error].blank?
      "<div class='message error'>" + flash[:error] + "</div>"
    end
  end
  
  def page_title
    if controller_name == "posts" && action_name == "show"
      "#{SITE_NAME}: #{@post.title}"
    else
      SITE_NAME
    end
  end
  
  def homepage?
    controller_name == 'posts' && action_name == 'index'
  end  
end
