require 'spec_helper'

describe "volunteers/show" do
  before(:each) do
    @volunteer = assign(:volunteer, stub_model(Volunteer,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
