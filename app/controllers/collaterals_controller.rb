class CollateralsController < ApplicationController
  before_action :set_collateral, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /collaterals
  def index
    @collaterals = Collateral.all
  end

  # GET /collaterals/1
  def show
  end

  # GET /collaterals/new
  def new
    @collateral = Collateral.new
  end

  # GET /collaterals/1/edit
  def edit
  end

  # POST /collaterals
  def create
    @collateral = Collateral.new(collateral_params)

    if @collateral.save
      redirect_to @collateral, notice: 'Collateral was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /collaterals/1
  def update
    if @collateral.update(collateral_params)
      redirect_to @collateral, notice: 'Collateral was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /collaterals/1
  def destroy
    @collateral.destroy
    redirect_to collaterals_url, notice: 'Collateral was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collateral
      @collateral = Collateral.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def collateral_params
      params.require(:collateral).permit(:name, :link, :kind)
    end
end
