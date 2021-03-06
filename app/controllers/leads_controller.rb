class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  BEST_COLLATERALS_FOR_LEAD_NUMBER = 10
  # GET /leads
  def index
    @leads = Lead.includes(:tags).all
  end

  # GET /leads/1
  def show
    @collaterals = []
    @colls = []
    @collaterals = search_best_for_lead.take(BEST_COLLATERALS_FOR_LEAD_NUMBER)
    @collaterals = search_best_for_lead.each do |c|
      @colls << c.pop
    end
    @collaterals.flatten!
  end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  def tags
    @lead = Lead.includes(:tags).find params["lead_id"]
    @tags = Tag.all
  end

  def assign_tags
    tag_params = params['new_tag']
    tag_to_assign = Tag.where(name: tag_params['name'].downcase, category: tag_params['category']).first_or_create
    current_lead = Lead.includes(:tags).find params['lead_id']

    unless current_lead.tags.include?(tag_to_assign)
      TagAssignment.assign(tag_to_assign, current_lead, tag_params['weight'].to_f)
    end

    redirect_to lead_tags_url
  end

  def deassign_tag
    tag_to_remove = params['tag']
    lead = Lead.includes(:tags).find params["lead_id"]
    lead.tags = Lead.tags.where.not(id: tag_to_remove)

    redirect_to lead_tags_url

  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to @lead, notice: 'Lead was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /leads/1
  def update
    if @lead.update(lead_params)
      redirect_to @lead, notice: 'Lead was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /leads/1
  def destroy
    @lead.destroy
    redirect_to leads_url, notice: 'Lead was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def lead_params
    params.require(:lead).permit(:name, :description)
  end
end
