require 'spec_helper'

describe "batches/index" do
  before(:each) do
    assign(:batches, [
      stub_model(Batch,
        :no => "No",
        :gender => "Gender",
        :blessing_id => 1
      ),
      stub_model(Batch,
        :no => "No",
        :gender => "Gender",
        :blessing_id => 1
      )
    ])
  end

  it "renders a list of batches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "No".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
