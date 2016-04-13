class ExpendituresController < ApplicationController
  include ApplicationHelper
  
  before_filter :authenticate_user!

  has_scope :period_start
  has_scope :period_end
  has_scope :category

  def index
    @expenditures = apply_scopes(current_user.expenditures)
    @expenditures_sum = @expenditures.sum(:amount)
   
    if current_scopes[:category].present?
      @category = current_user.categories.find_by_id(current_scopes[:category])
    end
  end

  def show
    @expenditure = Expenditure.find(params[:id])

    unless@expenditure.owner? current_user
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end
  end

  def new
    @expenditure = Expenditure.new
    @categories = current_user.categories
    @categories_array = @categories.map { |category| [category.name, category.id] }
    @ofteness = ["daily", "monthly", "extra"]
    @month_percentage = current_user.month_percentage
    if @month_percentage < 80
      @class = "progressbar_green"
    else
      @class = "progressbar_yellow"
      if @month_percentage > 100
        @month_percentage = 100
      end
    end
  end

  def edit 
    @expenditure = Expenditure.find(params[:id])
    @ofteness = ["daily", "monthly", "extra"]
    
    if @expenditure.owner? current_user       
      @categories = current_user.categories
      @categories_array = @categories.map { |category| [category.name, category.id] }
    else
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end      
  end

  def create
    @expenditure = Expenditure.new(expenditure_params)
    @expenditure.user = current_user

    if @expenditure.save
      redirect_to root_path
    else
      render action: "new"
    end
  end

  def update
    @expenditure = Expenditure.find(params[:id])

    if @expenditure.owner? current_user
      if @expenditure.update_attributes(expenditure_params)
        redirect_to @expenditure, notice: 'Expenditure was successfully updated.'
      else
        render action: "edit"
      end
    else
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end      
  end

  def destroy
    @expenditure = Expenditure.find(params[:id])
    
    if @expenditure.owner? current_user
      @expenditure.destroy
      redirect_to expenditures_url
    else
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end
  end  

  private

  def expenditure_params
    params.require(:expenditure).permit(:amount, :category_id, :description,
                                        :ofteness, :date)
  end
end
