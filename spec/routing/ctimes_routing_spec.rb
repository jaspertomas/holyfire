require "spec_helper"

describe CtimesController do
  describe "routing" do

    it "routes to #index" do
      get("/ctimes").should route_to("ctimes#index")
    end

    it "routes to #new" do
      get("/ctimes/new").should route_to("ctimes#new")
    end

    it "routes to #show" do
      get("/ctimes/1").should route_to("ctimes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ctimes/1/edit").should route_to("ctimes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ctimes").should route_to("ctimes#create")
    end

    it "routes to #update" do
      put("/ctimes/1").should route_to("ctimes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ctimes/1").should route_to("ctimes#destroy", :id => "1")
    end

  end
end
