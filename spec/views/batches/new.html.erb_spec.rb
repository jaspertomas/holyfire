require 'spec_helper'

describe "batches/new" do
  before(:each) do
    assign(:batch, stub_model(Batch,
      :no => "MyString",
      :gender => "MyString",
      :blessing_id => 1
    ).as_new_record)
  end

  it "renders new batch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => batches_path, :method => "post" do
      assert_select "input#batch_no", :name => "batch[no]"
      assert_select "input#batch_gender", :name => "batch[gender]"
      assert_select "input#batch_blessing_id", :name => "batch[blessing_id]"
    end
  end
end
