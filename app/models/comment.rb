class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :body
  validates_presence_of :name
  validates_format_of   :email,
    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :if => Proc.new{|c| !c.email.blank?}
  after_create :notify_comment
  validate :only_intersting_comments

  protected
  def notify_comment
    Notifier.deliver_comment_notification(self)
  end

  def only_intersting_comments
    ENV['blacklist'].to_s.split(',').each do |word|
      if self.body.include?(word)
        errors.add_to_base(I18n.t('comments.commenting_system.no_spam',
          :word => word))
      end
    end
  end
end
