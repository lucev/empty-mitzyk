class ExpendituresController < ApplicationController

  before_filter :authenticate_user!
  # GET /expenditures
  # GET /expenditures.json
  def index
    @expenditures = Expenditure.where("user_id = ?", current_user.id).order("date desc")

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
