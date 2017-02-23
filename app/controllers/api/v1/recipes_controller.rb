class Api::V1::RecipesController < Api::V1::BaseController 

  def index
    response = {recipes: [], release: Release.first.version} 
    if has_results?
      expose generate_recipe_response response
    else
      response[:end_of_results] = true 
      expose response
    end
  end

  private

  def buying_guide_query
    Bygdlnk.limit(params[:per_page].to_i)
           .offset(@offset)
           .order(CN_Code: :desc)
           .includes(:fdes, :buygd, :ctgnme, :nutvals, :nutdes, :wghts)
  end

  def has_results?
    params[:page] ||= 1
    params[:per_page] ||= 25 
    @offset = (params[:page].to_i - 1) * params[:per_page].to_i
    @offset <= Fdes.count
  end

  def generate_recipe_response response
    buying_guide_query.each do |guide|
      recipe = {id: guide.CN_Code, weights: []}
      guide.wghts.each do |weight|
        recipe[:weights] << generate_weight_response(guide, weight)
      end
      response[:recipes] << recipe 
    end
    return response
  end

  def generate_nutrient_values buying_guide, weight_in_grams, recipe_weight_response
    # Adjusts the nutrient values by their weight in grams
    buying_guide.nutvals.each do |nutval|
      if !nutval.Nutrient_Value.nil? 
        value = (nutval.Nutrient_Value * (weight_in_grams/100))
      else
        value = nil
      end
      recipe_weight_response[nutval.nutdes.Nutrient_Description] = value
    end
    return recipe_weight_response
  end

  def generate_weight_response buying_guide, weight
    weight_response = {
      id: "#{buying_guide.CN_Code}-#{(weight.Gram_Weight*100).to_i}",
      recipe_id: buying_guide.CN_Code,
      name: buying_guide.fdes.Abbr_Desc.titleize,
      description: buying_guide.fdes.Descriptor, 
      weight: weight.Gram_Weight,
      amount: weight.Amount,
      measure_desc: weight.Measure_desc,
      cnd_code: buying_guide.CN_Code,
      category: buying_guide.ctgnme.Category_Description
    } 
    return generate_nutrient_values(buying_guide, weight.Gram_Weight, weight_response)
  end
end
