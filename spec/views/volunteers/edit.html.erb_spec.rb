require 'spec_helper'

describe "volunteers/edit" do
  before(:each) do
    @volunteer = assign(:volunteer, stub_model(Volunteer,
      :name => "MyString"
    ))
  end

  it "renders the edit volunteer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => volunteers_path(@volunteer), :method => "post" do
      assert_select "input#volunteer_name", :name => "volunteer[name]"
    end
  end
end
