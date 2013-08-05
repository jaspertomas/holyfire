require 'spec_helper'

describe "ctimes/show" do
  before(:each) do
    @ctime = assign(:ctime, stub_model(Ctime,
      :span => "Span",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Span/)
    rendered.should match(/Value/)
  end
end
