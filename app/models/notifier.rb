class Notifier < ActionMailer::Base
  def comment_notification(comment)
    setup_email(comment)
    @subject    += I18n.t('comments.email.comment_notification_subject')
    if RAILS_ENV == 'production'
      @url = "http://#{APP_CONFIG['site_url']}#{post_path(comment.post)}"
    else
      @url = "http://#{ENV['site_url']}#{post_path(comment.post)}"
    end
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
    @recipients  = RAILS_ENV == 'production' ? "#{ENV['email']}" : "#{ENV['email']}"
    @subject     = RAILS_ENV == 'production' ?  "#{ENV['site_url']} blog: " : "#{APP_CONFIG['site_url']} blog: "
    @from        = element.email
    @sent_on     = Time.now
  end
end
