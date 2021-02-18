class CollateralsController < ApplicationController
  before_action :set_collateral, only: [:show, :edit, :update, :destroy]
  # GET /collaterals
  def index
    @collaterals = Collateral.includes(:tags).all
    stack_tags = Tag.where(category: "stack").all.order(:name)
    domain_tags = Tag.where(category: "domain").all.order(:name)
    language_tags = Tag.where(category: "language").all.order(:name)
    country_tags = Tag.where(category: "country").all.order(:name)
    @kinds = Collateral.kinds.sort
    @selected_tags = {}
    @selected_kinds = []
    @tag_filters = { stack_tags: stack_tags,
                     domain_tags: domain_tags,
                     language_tags: language_tags,
                     country_tags: country_tags }
  end

  # GET /collaterals/1
  def show
    @collateral = Collateral.find(params[:id])
  end

  def search_collaterals
    filters = params
    # params cleaning
    tag_params = filters['search']

    tag_params.transform_values! do |v|
      v.shift
      v.map!(&:to_i)
      v
    end
    tag_params.delete_if { |_, v| v.blank? }
    @selected_tags = tag_params

    collateral_kinds = tag_params.delete('kinds')
    # generate search_patterns
    search_patterns = []
    args = []

    args = tag_params.values
    search_patterns, rest = Array.wrap(args[0]), Array.wrap(args[1..-1])
    search_patterns = search_patterns.product(*rest)

    # search collaterals with search_patterns
    found_collaterals_ids = []
    search_patterns.each do |ids|
      Collateral.joins(:tags).group(:id).having("array_agg(tags.id) @> ARRAY[?]::bigint[]", ids).each do |c|
        found_collaterals_ids << c.id
      end
    end

    if collateral_kinds.blank?
      @collaterals = Collateral.where(id: found_collaterals_ids)
    elsif tag_params.empty?
      @collaterals = Collateral.where(kind: collateral_kinds)
    else
      @collaterals = Collateral.where(id: found_collaterals_ids).where(kind: collateral_kinds)
    end
    @selected_kinds = collateral_kinds.blank? ? [] : collateral_kinds
    stack_tags = Tag.where(category: "stack").all.order(:name)
    domain_tags = Tag.where(category: "domain").all.order(:name)
    language_tags = Tag.where(category: "language").all.order(:name)
    country_tags = Tag.where(category: "country").all.order(:name)
    @kinds = Collateral.kinds.sort

    @tag_filters = { stack_tags: stack_tags,
                     domain_tags: domain_tags,
                     language_tags: language_tags,
                     country_tags: country_tags }
    render :index
  end

  def search_best_for_lead
    @lead_tags = Lead.find(params[:id])
    search_result = []
    Collateral.all.each do |x|
      wagged = 0
      x.tags.each do |y|
        @lead_tags.each do |z|
          wagged += z.weight * y.weight if z.name == y.name
        end
      end
      search_result << [x.id, wagged]
    end
    search_result.sort.reverse
  end

  # GET /collaterals/new
  def new
    @collateral = Collateral.new
  end

  # GET /collaterals/1/tags
  def tags
    @collateral = Collateral.includes(:tags).find params["collateral_id"]
    @tags = Tag.all
    @tag_to_add = Tag.new
  end

  def assign_tags
    tag_params = params['tag']
    tag_to_assign = Tag.where(name: tag_params['name'].downcase, category: tag_params['category']).first_or_create
    current_collateral = Collateral.includes(:tags).find params['collateral_id']

    unless current_collateral.tags.include?(tag_to_assign)
      current_collateral.tags << tag_to_assign
    end

    redirect_to collateral_tags_url
  end

  def deassign_tag
    tag_to_remove = params['tag']
    collateral = Collateral.includes(:tags).find params["collateral_id"]
    collateral.tags = collateral.tags.where.not(id: tag_to_remove)

    redirect_to collateral_tags_url

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
    params.require(:collateral).permit(:name, :link, :kind, :search, :stack_tags, :domain_tags, :language_tags, :country_tags, :kinds)
  end
end