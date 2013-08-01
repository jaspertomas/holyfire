require 'spec_helper'

describe "ctimes/edit" do
  before(:each) do
    @ctime = assign(:ctime, stub_model(Ctime,
      :span => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit ctime form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ctimes_path(@ctime), :method => "post" do
      assert_select "input#ctime_span", :name => "ctime[span]"
      assert_select "input#ctime_value", :name => "ctime[value]"
    end
  end
end
