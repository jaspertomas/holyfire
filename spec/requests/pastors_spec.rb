require 'spec_helper'

describe "Pastors" do
  describe "GET /pastors" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get pastors_path
      response.status.should be(200)
    end
  end
end
