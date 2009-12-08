class Post < ActiveRecord::Base
  has_many :comments

  def to_param
    id.to_s << "-" << (title ? title.parameterize : '' )
  end
end
