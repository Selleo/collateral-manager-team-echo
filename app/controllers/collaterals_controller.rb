class CollateralsController < ApplicationController
  before_action :set_collateral, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /collaterals
  def index
    @collaterals = Collateral.includes(:tags).all
    stack_tags = Tag.where(category: "stack").all.order(:name)
    domain_tags = Tag.where(category: "domain").all.order(:name)
    language_tags = Tag.where(category: "language").all.order(:name)
    country_tags = Tag.where(category: "country").all.order(:name)
    @kinds = Collateral.kinds.sort

    @tag_filters = { stack_tags: stack_tags,
                     domain_tags: domain_tags,
                     language_tags: language_tags,
                     country_tags: country_tags }
  end

  # GET /collaterals/1
  def show
    @collateral = Collateral.find(params[:id])
  end

  def search
    tag_params = {"search"=>{
                                "stack_tags"=>["", "1"],
                                "domain_tags"=>["", "3"],
                                "language_tags"=>["", "2"],
                                "country_tags"=>["", ""],
                                "kinds"=>["", "3", "9", "10"]
                                },
                  "search-text"=>" "}

    # params cleaning
    text_param = tag_params["search-text"]
    tag_params = tag_params['search']

    tag_params.each do |key, val|
      val_clean = []
      val.each do |v|
        val_clean << v if v != ""
      end
      tag_params[key] = val_clean.join(',')
    end
    # sql query generate
    query = "SELECT DISTINCT collaterals.name FROM collaterals
                            INNER JOIN collaterals_tags
                            ON collaterals.id = collaterals_tags.collateral_id
                            INNER JOIN tags
                            ON collaterals_tags.tag_id = tags.id
                            WHERE "
    query += "collaterals.name LIKE '%#{text_param}%'" #if text_param.strip!.size > 0
    tag_params.each do |key, val|
      query += " AND tags.id IN (#{tag_params[key]})" if tag_params[key].size > 0
    end

    @collaterals = Collateral.find_by_sql(query)

    # Collateral.find_by_sql("SELECT DISTINCT collaterals.name FROM collaterals
    #                         INNER JOIN collaterals_tags
    #                         ON collaterals.id = collaterals_tags.collateral_id
    #                         INNER JOIN tags
    #                         ON collaterals_tags.tag_id = tags.id
    #                         WHERE collaterals.name LIKE '%uby%' AND
    #                         collaterals.kind IN (3, 2, 10) AND
    #                         tags.id IN (0) AND
    #                         tags.id IN (2) AND
    #                         tags.id IN (1, 3) AND
    #                         tags.id IN (2, 7)")
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

  def search_collaterals
    filters = params
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
    params.require(:collateral).permit(:name, :link, :kind, :search,:stack_tags, :domain_tags, :language_tags, :country_tags, :kinds)
  end
end