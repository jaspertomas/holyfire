require 'spec_helper'

describe "pastors/index" do
  before(:each) do
    assign(:pastors, [
      stub_model(Pastor,
        :name => "Name",
        :chinesename => "Chinesename"
      ),
      stub_model(Pastor,
        :name => "Name",
        :chinesename => "Chinesename"
      )
    ])
  end

  it "renders a list of pastors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Chinesename".to_s, :count => 2
  end
end
