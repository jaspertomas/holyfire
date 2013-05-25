require 'spec_helper'

describe "blessings/edit" do
  before(:each) do
    @blessing = assign(:blessing, stub_model(Blessing,
      :location => "MyString",
      :contactinfo => "MyText",
      :comments => "MyText"
    ))
  end

  it "renders the edit blessing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blessings_path(@blessing), :method => "post" do
      assert_select "input#blessing_location", :name => "blessing[location]"
      assert_select "textarea#blessing_contactinfo", :name => "blessing[contactinfo]"
      assert_select "textarea#blessing_comments", :name => "blessing[comments]"
    end
  end
end
