class Api::V1::RecipesController < Api::V1::BaseController 
  def index
    response = {recipes: []} 
    offset = params[:page].to_i * params[:per_page].to_i
    Bygdlnk.limit(params[:per_page].to_i).offset(offset).order(CN_Code: :desc).includes(:fdes, :ctgnme, :nutvals, :nutdes, :buygd, :wghts).each do |link|

      link.wghts.each do |weight|
        response_hash = {
          id: "#{link.CN_Code}-#{(weight.Gram_Weight*100).to_i}",
          name: link.fdes.Abbr_Desc.titleize,
          description: link.fdes.Descriptor, 
          weight: weight.Gram_Weight,
          amount: weight.Amount,
          measure_desc: weight.Measure_desc,
          cnd_code: link.CN_Code,
          category: link.fdes.ctgnme.Category_Description
        }

        link.nutvals.each do |nutval|
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
