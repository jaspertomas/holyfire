require 'spec_helper'

describe "ctimes/new" do
  before(:each) do
    assign(:ctime, stub_model(Ctime,
      :span => "MyString",
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new ctime form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ctimes_path, :method => "post" do
      assert_select "input#ctime_span", :name => "ctime[span]"
      assert_select "input#ctime_value", :name => "ctime[value]"
    end
  end
end
