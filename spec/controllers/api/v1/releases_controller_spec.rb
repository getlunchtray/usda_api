require 'rails_helper'

RSpec.describe Api::V1::ReleasesController, type: :controller do
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

    it "returns the first version" do
      get :index, {version: 1} 
      expect(read_json_response(response)[:latest_release]).to eq(Release.first.version)
    end

    it "returns nil"
  end
end
