require 'rails_helper'

RSpec.describe Api::V1::ReleasesController, type: :controller do
  context "authentication" do 
    it "requires authentication" do
      get :index, version: 1
      expect(response.code).to eq("401")
    end
  end
end
