require 'spec_helper'

describe "pastors/new" do
  before(:each) do
    assign(:pastor, stub_model(Pastor,
      :name => "MyString",
      :chinesename => "MyString"
    ).as_new_record)
  end

  it "renders new pastor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pastors_path, :method => "post" do
      assert_select "input#pastor_name", :name => "pastor[name]"
      assert_select "input#pastor_chinesename", :name => "pastor[chinesename]"
    end
  end
end
