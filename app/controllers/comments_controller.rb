class CommentsController < ApplicationController

  def index
    comments = Comment.order('created_at desc')
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def edit    
    @comment = Comment.find(params[:id])
    if @comment.user_id != session[:current_user_authenticated]
      flash[:error] = t(:different_owner)
      redirect_to :back 
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = session[:current_user_authenticated]
    @comment.idea_id = params[:idea_id]

    if @comment.save
      redirect_to idea_url(params[:idea_id]), :anchor => "commentPost", notice: 'Comment was successfully created.' 
    else
      flash[:error] = "Something wrong happened when saving the comment"
      redirect_to idea_url(params[:idea_id]), :anchor => "commentPost"
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.user_id != session[:current_user_authenticated]
      flash[:error] = t(:different_owner)
      redirect_to :back 
    else
      if @comment.update_attributes(params[:comment])
        redirect_to idea_url(@comment.idea_id), :anchor => "commentPost", notice: "Comment was successfully updated."
      else
        flash[:error] = "Something wrong happened when saving the comment"
        redirect_to idea_url(@comment.idea_id), :anchor => "commentPost"
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == session[:current_user_authenticated]
      @comment.destroy
      redirect_to ideas_url, notice: 'Comment was successfully destroyed.' 
    else
      flash[:error] = t(:different_owner)
      redirect_to :back, :anchor => "commentPost"
    end
  end

end
