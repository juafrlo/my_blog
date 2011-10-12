class PostsController < ApplicationController
  before_filter :find_seo_id
  before_filter :admin_required, :except => [:index, :show, :search]
  before_filter :only_active, :only =>[:show]
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.active.ordered.paginate :per_page => 5, :page => params[:page]                                     

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.rss { render :action => "index.rxml", :layout => false }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = t("controllers.posts.post_created")
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = t("controllers.posts.post_updated")
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    unless params[:tag].blank?    
      head :moved_permanently, :location => tag_path(params[:tag].parameterize.to_s)
      return
    else
      @posts = Post.ordered.find_by_regexp_title(params[:title]).paginate :per_page => 5,
       :page => params[:page]
    end
    render :action => 'index'
  end
  
  protected
  def only_active
    @post = Post.find(params[:id])
    if !@post.active && session[:admin].blank?
      head :moved_permanently, :location => home_url
    end
  end
  
  def find_seo_id
    unless params[:id].blank?
      seo_id = params[:id].scan(/.+-(.+)?/).flatten.first.to_i rescue 0
      if seo_id != 0
        params[:id] = seo_id
      else
        old_id = params[:id].scan(/(\d+).+/).to_s
        new_url = request.url.gsub(/#{old_id}-/,'') << "-#{old_id}"
        head :moved_permanently, :location => new_url
      end
    end
  end
end