require "spec_helper"

describe BlessingsController do
  describe "routing" do

    it "routes to #index" do
      get("/blessings").should route_to("blessings#index")
    end

    it "routes to #new" do
      get("/blessings/new").should route_to("blessings#new")
    end

    it "routes to #show" do
      get("/blessings/1").should route_to("blessings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blessings/1/edit").should route_to("blessings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blessings").should route_to("blessings#create")
    end

    it "routes to #update" do
      put("/blessings/1").should route_to("blessings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blessings/1").should route_to("blessings#destroy", :id => "1")
    end

  end
end
