class Notifier < ActionMailer::Base
  def comment_notification(comment)
    setup_email(comment)
    @subject    += I18n.t('comments.email.comment_notification_subject')
    @url = "http://#{APP_CONFIG['site_url']}#{post_path(comment.post)}"
  end  
  
  protected
  def setup_email(comment)
    content_type "text/html"
    @recipients  = "#{APP_CONFIG['email']}"
    @from        = comment.email
    @subject     = "#{APP_CONFIG['site_url']} blog: "
    @sent_on     = Time.now
  end
end
