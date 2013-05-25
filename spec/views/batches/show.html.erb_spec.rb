require 'spec_helper'

describe "batches/show" do
  before(:each) do
    @batch = assign(:batch, stub_model(Batch,
      :no => "No",
      :gender => "Gender",
      :blessing_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/No/)
    rendered.should match(/Gender/)
    rendered.should match(/1/)
  end
end
