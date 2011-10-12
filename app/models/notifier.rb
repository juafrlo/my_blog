class Notifier < ActionMailer::Base
  def comment_notification(comment)
    setup_email(comment)
    @subject    += I18n.t('comments.email.comment_notification_subject')
    if RAILS_ENV == 'production'
      @url = "http://#{APP_CONFIG['site_url']}#{post_path(comment.post)}"
    else
      @url = "http://#{ENV['site_url']}#{post_path(comment.post)}"
    end
        
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
    if RAILS_ENV == 'production'
      @recipients  = "#{ENV['email']}"
    else
      @recipients  = "#{APP_CONFIG['email']}"
    end
    @from        = element.email
    if RAILS_ENV == 'production'
      @subject     = "#{ENV['site_url']} blog: "
    else
      @subject     = "#{APP_CONFIG['site_url']} blog: "
    end
    @sent_on     = Time.now
  end
end
