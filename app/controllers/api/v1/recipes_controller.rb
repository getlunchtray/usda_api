class Api::V1::RecipesController < Api::V1::BaseController 
  def index
    response = {recipes: [], release: Release.first.version} 
    offset = params[:page].to_i * params[:per_page].to_i
    if offset > Fdes.count
      response[:end_of_results] = true 
      expose response
    else
      Bygdlnk.limit(params[:per_page].to_i).offset(offset).order(CN_Code: :desc).includes(:fdes, :buygd, :ctgnme, :nutvals, :nutdes, :wghts).each do |guide|

        guide.wghts.each do |weight|
          response_hash = {
            id: "#{guide.CN_Code}-#{(weight.Gram_Weight*100).to_i}",
            name: guide.fdes.Abbr_Desc.titleize,
            description: guide.fdes.Descriptor, 
            weight: weight.Gram_Weight,
            amount: weight.Amount,
            measure_desc: weight.Measure_desc,
            cnd_code: guide.CN_Code,
            category: guide.ctgnme.Category_Description
          }

          guide.nutvals.each do |nutval|
            if !nutval.Nutrient_Value.nil? 
              value = (nutval.Nutrient_Value * (weight.Gram_Weight/100))
            else
              value = nil
            end
            response_hash[nutval.nutdes.Nutrient_Description] = value
          end

          response[:recipes] << response_hash
        end
      end
      
      expose response
    end
  end
end
