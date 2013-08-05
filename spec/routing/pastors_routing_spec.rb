require "spec_helper"

describe PastorsController do
  describe "routing" do

    it "routes to #index" do
      get("/pastors").should route_to("pastors#index")
    end

    it "routes to #new" do
      get("/pastors/new").should route_to("pastors#new")
    end

    it "routes to #show" do
      get("/pastors/1").should route_to("pastors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pastors/1/edit").should route_to("pastors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pastors").should route_to("pastors#create")
    end

    it "routes to #update" do
      put("/pastors/1").should route_to("pastors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pastors/1").should route_to("pastors#destroy", :id => "1")
    end

  end
end
