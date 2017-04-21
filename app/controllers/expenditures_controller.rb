class ExpendituresController < ApplicationController
  include ApplicationHelper

  load_and_authorize_resource
  load_and_authorize_resource :category, only: :index

  has_scope :period_start
  has_scope :period_end
  has_scope :category, as: :category_id

  def index
    @expenditures = apply_scopes(current_user.expenditures).order(date: :desc, created_at: :desc)
    @category_expenditures = @expenditures.group(:category).reorder('sum_amount DESC').sum(:amount)
    @expenditures_sum = @expenditures.sum(:amount)
  end

  def show
  end

  def new
    @categories = current_user.categories.active
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
    @ofteness = ["daily", "monthly", "extra"]
    @categories = current_user.categories
    @categories_array = @categories.map { |category| [category.name, category.id] }
  end

  def create
    @expenditure = current_user.expenditures.build(expenditure_params)
    @expenditure.amount = ExpenditureConverter.new(current_user, expenditure_params).converted_amount

    if @expenditure.save
      redirect_to root_path
    else
      render action: "new"
    end
  end

  def update
    @expenditure.assign_attributes(expenditure_params)
    @expenditure.amount = ExpenditureConverter.new(current_user, expenditure_params).converted_amount
    if @expenditure.save
      redirect_to @expenditure, notice: 'Expenditure was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @expenditure.destroy
    redirect_to expenditures_url
  end  

  private

  def expenditure_params
    params.require(:expenditure).permit(:amount, :category_id, :description,
                                        :ofteness, :date, :currency)
  end
end
