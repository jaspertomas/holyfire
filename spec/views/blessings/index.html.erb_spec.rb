require 'spec_helper'

describe "blessings/index" do
  before(:each) do
    assign(:blessings, [
      stub_model(Blessing,
        :location => "Location",
        :contactinfo => "MyText",
        :comments => "MyText"
      ),
      stub_model(Blessing,
        :location => "Location",
        :contactinfo => "MyText",
        :comments => "MyText"
      )
    ])
  end

  it "renders a list of blessings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
