require 'spec_helper'

describe "ctimes/index" do
  before(:each) do
    assign(:ctimes, [
      stub_model(Ctime,
        :span => "Span",
        :value => "Value"
      ),
      stub_model(Ctime,
        :span => "Span",
        :value => "Value"
      )
    ])
  end

  it "renders a list of ctimes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Span".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
