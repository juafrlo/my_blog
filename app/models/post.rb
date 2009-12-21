class Post < ActiveRecord::Base
  acts_as_taggable
  has_many :comments, :dependent => :destroy
  
  named_scope :ordered, :order => "created_at DESC"
  
  def to_param
    id.to_s << "-" << (title ? title.parameterize : '' )
  end
  
  def self.find_by_regexp_title(title)
    Post.find(:all, :conditions => ["title Regexp ?", title.blank? ? '&' : title])
  end
end
