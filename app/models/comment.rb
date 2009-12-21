class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :body
  validates_presence_of :name
  validates_format_of   :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => Proc.new{|c| !c.email.blank?}   
  validates_length_of :extra_field, :maximum => 0, :message => "I don't want spam"
  after_create :notify_comment
  
  protected
  def notify_comment
    Notifier.deliver_comment_notification(self)
  end
end
