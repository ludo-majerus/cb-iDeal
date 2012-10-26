class CategoriesController < ApplicationController
  def index
    @categories = User.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
  end
end
