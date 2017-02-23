module JsonHelpers
  def read_json_response response 
    JSON.parse(response.body).with_indifferent_access[:response]
  end
end
