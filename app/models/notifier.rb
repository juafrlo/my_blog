class Notifier < ActionMailer::Base
  def comment_notification(comment)
    setup_email(comment)
    @subject    += I18n.t('comments.email.comment_notification_subject')
    @url = "http://#{APP_CONFIG['site_url']}#{post_path(comment.post)}"
    @post = comment.post
  end  
  
  def contact_notification(contact)
    setup_email(contact)
    @subject    += I18n.t('contacts.email.contact_notification_subject')
    @contact = contact
  end
  
  protected
  def setup_email(element)
    content_type "text/html"
    @recipients  = "#{APP_CONFIG['email']}"
    @from        = element.email
    @subject     = "#{APP_CONFIG['site_url']} blog: "
    @sent_on     = Time.now
  end
end
