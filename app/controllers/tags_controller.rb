class TagsController < ApplicationController
  def show
    @posts = Post.ordered.active.find_tagged_with(params[:id].gsub('-',' ')).paginate :per_page => 5,
      :page => params[:page]    
    render( :template=> 'posts/index' )    
  end
end