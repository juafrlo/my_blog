class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name(params[:id].gsub('-',' '))
    @posts = Post.ordered.active.find_tagged_with(@tag.name).paginate :per_page => 5,
      :page => params[:page]    
    render( :template=> 'posts/index' )    
  end
end