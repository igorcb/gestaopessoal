class SubCostCentersController < ApplicationController
  before_action :set_sub_cost_center, only: [:show, :edit, :update, :destroy]

  def sub_cost_centers_three_by_sub_cost_center
    cost_center_id = params[:cost_center_id].to_i
    sub_cost_center_id = params[:sub_cost_center_id].to_i
    subs = SubCostCenterThree.where(cost_center_id: cost_center_id, sub_cost_center_id: sub_cost_center_id)
    sub = []
    subs.each do |s|
      sub << {:id => s.id, :n => s.nome}
    end
    render :text => sub.to_json
  end

  # GET /sub_cost_centers
  # GET /sub_cost_centers.json
  def index
    @sub_cost_centers = SubCostCenter.all
  end

  # GET /sub_cost_centers/1
  # GET /sub_cost_centers/1.json
  def show
  end

  # GET /sub_cost_centers/new
  def new
    @sub_cost_center = SubCostCenter.new
  end

  # GET /sub_cost_centers/1/edit
  def edit
  end

  # POST /sub_cost_centers
  # POST /sub_cost_centers.json
  def create
    @sub_cost_center = SubCostCenter.new(sub_cost_center_params)

    respond_to do |format|
      if @sub_cost_center.save
        format.html { redirect_to @sub_cost_center, notice: 'Sub cost center was successfully created.' }
        format.json { render :show, status: :created, location: @sub_cost_center }
      else
        format.html { render :new }
        format.json { render json: @sub_cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_cost_centers/1
  # PATCH/PUT /sub_cost_centers/1.json
  def update
    respond_to do |format|
      if @sub_cost_center.update(sub_cost_center_params)
        format.html { redirect_to @sub_cost_center, notice: 'Sub cost center was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_cost_center }
      else
        format.html { render :edit }
        format.json { render json: @sub_cost_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_cost_centers/1
  # DELETE /sub_cost_centers/1.json
  def destroy
    @sub_cost_center.destroy
    respond_to do |format|
      format.html { redirect_to sub_cost_centers_url, notice: 'Sub cost center was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_cost_center
      @sub_cost_center = SubCostCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_cost_center_params
      params.require(:sub_cost_center).permit(:cost_center_id, :nome)
    end
end
