require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  context "authentication" do 
    it "requires authentication" do
      get :index, version: 1
      expect(response.code).to eq("401")
    end

    it "requires valid authentication" do
      user = create(:user)
      @request.env["HTTP_AUTHORIZATION"] = "Token token=\"1234\", user_id=\"#{user.id}\""
      get :index, {version: 1}
      expect(response.code).to eq("401")
    end
  end

  describe "index" do
    let(:user){create(:user)}
    let(:token){user.set_authentication_token}
  
    before(:each) do
      @request.env["HTTP_AUTHORIZATION"] = "Token token=\"#{token}\", user_id=\"#{user.id}\""
    end

    it "allows users to grab a recipe list" do
      get :index, {version: 1}
      expect(response.code).to eq("200")
    end

    it "allows users to grab a recipe list" do
      get :index, {version: 1, per_page: 25, page: 1}
      expect(read_json_response(response)[:recipes].count).to eq(25)
    end

    it "returns end of results" do
      get :index, {version: 1, page: Fdes.count}
      expect(read_json_response(response)[:end_of_results]).to be true 
    end

  end

end
