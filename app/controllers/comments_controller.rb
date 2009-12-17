class CommentsController < ApplicationController
  before_filter :admin_required, :except => :create

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_ip = request.remote_ip
    @comment.save
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
