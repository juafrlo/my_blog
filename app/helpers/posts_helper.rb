module PostsHelper
  def post_title(post)
    action_name == 'show' ? post.title : link_to(post.title,post)
  end
  
  def date_block(date) 
    html = "<div class='dateblock'>"
      html +=  "<span class='dateblock_mon'>#{l(date, :format => 'month')}</span>"
      html +=  "<span class='dateblock_day'>#{l(date, :format => 'day')}</span>"
      html +=  "<span class='dateblock_year'>#{l(date, :format => 'year')}</span>"
    html += "</div>"
  end    

  def post_tags(post)
    html = ""
    post.tags.each do |tag|
      html += link_to tag
      html += ", " unless tag == post.tags.last
    end
    html
  end
end
