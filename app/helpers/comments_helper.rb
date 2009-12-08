require 'md5'
module CommentsHelper
  def gravatar_url_for(email, options = {})      
    url_for(
    { :gravatar_id => Digest::MD5.hexdigest(email), 
      :host => 'www.gravatar.com',                     
      :protocol => 'http://', 
      :only_path => false, 
      :controller => 'avatar.php'}.merge(options))  
   end
   
   def comment_avatar(comment)
     if comment.email.blank? 
       image_tag('avatar.png') 
     else
       image_tag('avatar.png') 
       #image_tag gravatar_url_for(comment.email, { :s => 40 })
     end
   end
   
   def comment_name(comment)
     comment.name.blank? ? t('.anonymous') : comment.name 
   end
   
   def comment_site_url(comment)
     "(" + link_to(comment.site_url, comment.site_url) + ")" unless comment.site_url.blank?
   end
   
   def delete_comment(comment)
     link_to_remote t('.delete'), 
       :update => '',
       :url => comment_path(comment.id) , :method => :delete,
       :confirm => t('.are_you_sure')
   end
end
