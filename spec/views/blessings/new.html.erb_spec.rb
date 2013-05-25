require 'spec_helper'

describe "blessings/new" do
  before(:each) do
    assign(:blessing, stub_model(Blessing,
      :location => "MyString",
      :contactinfo => "MyText",
      :comments => "MyText"
    ).as_new_record)
  end

  it "renders new blessing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => blessings_path, :method => "post" do
      assert_select "input#blessing_location", :name => "blessing[location]"
      assert_select "textarea#blessing_contactinfo", :name => "blessing[contactinfo]"
      assert_select "textarea#blessing_comments", :name => "blessing[comments]"
    end
  end
end
