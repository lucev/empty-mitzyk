class CategoriesController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
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
    if @category.update_attributes(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name, :position, :active)
  end
end
