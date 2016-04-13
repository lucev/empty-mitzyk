class CategoriesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @categories = current_user.categories
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

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name, :position)
  end
end
