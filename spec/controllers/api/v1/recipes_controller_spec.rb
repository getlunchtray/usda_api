require 'rails_helper'

RSpec.describe Api::V1::RecipesController, type: :controller do
  context "authentication" do 
    it "requires authentication" do
      get :index, version: 1
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
  end

end
