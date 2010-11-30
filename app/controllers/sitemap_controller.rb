class SitemapController < ApplicationController
  caches_page :index
  
  def index
    @posts = Post.ordered.active
    @tags = Tag.all

    headers['Content-Type'] = 'application/xml'
    render :layout => false
  end
end