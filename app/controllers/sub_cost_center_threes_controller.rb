class SubCostCenterThreesController < ApplicationController
  before_action :set_sub_cost_center_three, only: [:show, :edit, :update, :destroy]

  # GET /sub_cost_center_threes
  # GET /sub_cost_center_threes.json
  def index
    @sub_cost_center_threes = SubCostCenterThree.all
  end

  # GET /sub_cost_center_threes/1
  # GET /sub_cost_center_threes/1.json
  def show
  end

  # GET /sub_cost_center_threes/new
  def new
    @sub_cost_center_three = SubCostCenterThree.new
  end

  # GET /sub_cost_center_threes/1/edit
  def edit
  end

  # POST /sub_cost_center_threes
  # POST /sub_cost_center_threes.json
  def create
    @sub_cost_center_three = SubCostCenterThree.new(sub_cost_center_three_params)

    respond_to do |format|
      if @sub_cost_center_three.save
        format.html { redirect_to @sub_cost_center_three, notice: 'Sub cost center three was successfully created.' }
        format.json { render :show, status: :created, location: @sub_cost_center_three }
      else
        format.html { render :new }
        format.json { render json: @sub_cost_center_three.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_cost_center_threes/1
  # PATCH/PUT /sub_cost_center_threes/1.json
  def update
    respond_to do |format|
      if @sub_cost_center_three.update(sub_cost_center_three_params)
        format.html { redirect_to @sub_cost_center_three, notice: 'Sub cost center three was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_cost_center_three }
      else
        format.html { render :edit }
        format.json { render json: @sub_cost_center_three.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_cost_center_threes/1
  # DELETE /sub_cost_center_threes/1.json
  def destroy
    @sub_cost_center_three.destroy
    respond_to do |format|
      format.html { redirect_to sub_cost_center_threes_url, notice: 'Sub cost center three was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_cost_center_three
      @sub_cost_center_three = SubCostCenterThree.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_cost_center_three_params
      params.require(:sub_cost_center_three).permit(:cost_center_id, :sub_cost_center_id, :nome)
    end
end
