require 'spec_helper'

describe "blessings/show" do
  before(:each) do
    @blessing = assign(:blessing, stub_model(Blessing,
      :location => "Location",
      :contactinfo => "MyText",
      :comments => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Location/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
