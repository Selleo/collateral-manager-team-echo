class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def search_best_for_lead
    lead_tags = Lead.find(params[:id]).tag_assignments
    search_result = []
    Collateral.all.each do |x|
      wagged = 0
      x.tag_assignments.each do |y|
        lead_tags.each do |z|
          wagged += z.weight * y.weight if z.tag_id == y.tag_id
        end
      end
      search_result << [x, wagged]
    end
    search_result.sort_by! { |item| item[-1] }
    search_result.reverse!
  end
end
