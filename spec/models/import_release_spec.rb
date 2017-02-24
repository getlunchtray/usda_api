require 'rails_helper'

RSpec.describe ImportRelease do
  context "release check" do 
    it "aborts when release has already been imported" do
      expect(Release).to receive(:find_by).and_return true
      response = ImportRelease.new.perform
      expect(response).to eq("Release Already Exists")
    end

    it "runs import" do
      expect(Release).to receive(:find_by).and_return true 
      response = ImportRelease.new.perform
      expect(response).to eq("Release Already Exists")
    end
    
    it "expects version 20-7" do
      import = ImportRelease.new
      expect(import.version).to eq("20-7")
    end
  end


  context "import procedure" do
    it "imports without incident" do
      puts "\nTesting release importer, this will take a minute \n"
      expect(Release).to receive(:find_by).and_return false 
      import = ImportRelease.new.perform
    end
  end
end
