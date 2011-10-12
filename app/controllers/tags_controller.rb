class TagsController < ApplicationController
  def show
    @tag = Tag.find(:first, :conditions => ['LOWER(name) = ?', params[:id].gsub('-',' ')])
    
    @posts = Post.ordered.active.find_tagged_with(@tag.name).paginate :per_page => 5,
      :page => params[:page]    
    render( :template=> 'posts/index' )    
  end
end