class IdeasController < ApplicationController
  before_filter :require_login, :except => [:index, :show, :scoreup]
  before_filter :require_admin, :only => [:changestatus]
  before_filter :init

  def init
    if session[:idea_voted].nil? 
      session[:idea_voted] = []
    end
  end

  # GET /ideas
  def index
    if params[:search].present?
      @search = Idea.search(params[:search])
      @ideas = @search.paginate(:page => params[:page], :per_page => 3)   # or @search.relation to lazy load in view // @search.paginate(:page => params[:page])
    else
      if params[:category_id].nil?
        @ideas = Idea.paginate(:page => params[:page], :per_page => 3)
      else
        @ideas = Idea.where(["category_id = ?", params[:category_id]]).paginate(:page => params[:page], :per_page => 3)
      end
    end
    @categories = Category.all
  end

  # GET /ideas/1 
  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
    @categories = Category.all

  end

  # GET /ideas/1/edit
  def edit    
    @idea = Idea.find(params[:id])
    if @idea.user_id != session[:current_user_authenticated]
      flash[:error] = t(:different_owner)
      redirect_to :back 
    end
    @categories = Category.all
  end

  # POST /ideas
  def create
    @idea = Idea.new(params[:idea])
    @idea.user_id = session[:current_user_authenticated]
    @idea.score = 0
    @idea.published = 0

    if @idea.save
      redirect_to ideas_url, notice: 'Idea was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /ideas/1
  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(params[:idea])
      redirect_to ideas_url, notice: "Idea was successfully updated."
    else
      render action: "edit" 
    end
  end

  # DELETE /ideas/1
  def destroy
    @idea = Idea.find(params[:id])
    if @idea.user_id == session[:current_user_authenticated]
      @idea.destroy
      redirect_to ideas_url, notice: 'Idea was successfully destroyed.' 
    else
      flash[:error] = t(:different_owner)
      redirect_to :back
    end
  end

  # PUT /ideas/1/scoreup
  def scoreup
    if session[:idea_voted].index(params[:id]).nil? 
      @idea = Idea.find(params[:id])
      @idea.score.nil? ? @idea.score = 1 : @idea.score = @idea.score + 1
      @idea.save
      (session[:idea_voted] ||= []) << params[:id]
      redirect_to :back, notice: 'You liked this idea !' 
    else
      flash[:error] = "Already voted"
      redirect_to :back
    end
  end

  # PUT /ideas/1/scoreup
  def changestatus
    # 0. not published / 1. published
    @idea = Idea.find(params[:id])
    @idea.status.nil? || @idea.status == 0 ? @idea.status = 1 : @idea.status = 0
    @idea.save
    redirect_to :back, notice: 'You changed the status of the idea.' 
  end
end
