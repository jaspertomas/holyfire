require 'spec_helper'

describe "pastors/show" do
  before(:each) do
    @pastor = assign(:pastor, stub_model(Pastor,
      :name => "Name",
      :chinesename => "Chinesename"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Chinesename/)
  end
end
