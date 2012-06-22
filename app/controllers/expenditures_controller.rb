class ExpendituresController < ApplicationController
  include ApplicationHelper
  
  before_filter :authenticate_user!
  # GET /expenditures
  # GET /expenditures.json
  def index
#    @start_date = Time.parse("#{params[:start_date]}") unless params[:start_date].nil?
    if(params[:start_date].nil? or params[:end_date].nil?)
      @range_start = first_of_month
      @range_end = Date.today
    else
      @range_start = Date.civil(params[:start_date]["date(1i)"].to_i,
                              params[:start_date]["date(2i)"].to_i,
                              params[:start_date]["date(3i)"].to_i)
      @range_end = Date.civil(params[:end_date]["date(1i)"].to_i,
                            params[:end_date]["date(2i)"].to_i,
                            params[:end_date]["date(3i)"].to_i,)        
    end
    @expenditures = current_user.range_expenditures(@range_start, @range_end)
    @expenditures_sum = current_user.range_expenditures_sum(@range_start, @range_end)
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenditures }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
    @expenditure = Expenditure.find(params[:id])

    if @expenditure.owner? current_user
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @expenditure }
      end
    else
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end
  end

  # GET /expenditures/new
  # GET /expenditures/new.json
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
        
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/1/edit
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

  # POST /expenditures
  # POST /expenditures.json
  def create
    @expenditure = Expenditure.new(params[:expenditure])
    @expenditure.user = current_user

    respond_to do |format|
      if @expenditure.save
        format.html { redirect_to root_path }
        format.json { render json: @expenditure, status: :created, location: @expenditure }
      else
        format.html { render action: "new" }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.json
  def update
    @expenditure = Expenditure.find(params[:id])

    if @expenditure.owner? current_user
      respond_to do |format|
        if @expenditure.update_attributes(params[:expenditure])
          format.html { redirect_to @expenditure, notice: 'Expenditure was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @expenditure.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end      
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.json
  def destroy
    @expenditure = Expenditure.find(params[:id])
    
    if @expenditure.owner? current_user
      @expenditure.destroy

      respond_to do |format|
        format.html { redirect_to expenditures_url }
        format.json { head :no_content }
      end
    else
      flash[:notice] = "You don't have sufficient rights for this action!"
      redirect_to root_path
    end
  end  
end
