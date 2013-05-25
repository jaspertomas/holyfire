require 'spec_helper'

describe "participants/new" do
  before(:each) do
    assign(:participant, stub_model(Participant,
      :sex => "MyString",
      :name => "MyString",
      :age => "MyString",
      :occupation => "MyString",
      :introducer => "MyString",
      :guarantor => "MyString",
      :address => "MyString",
      :tel => "MyString",
      :missionary => "MyString",
      :remark => "MyString",
      :donation => "MyString",
      :batch_id => 1,
      :blessing_id => 1
    ).as_new_record)
  end

  it "renders new participant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => participants_path, :method => "post" do
      assert_select "input#participant_sex", :name => "participant[sex]"
      assert_select "input#participant_name", :name => "participant[name]"
      assert_select "input#participant_age", :name => "participant[age]"
      assert_select "input#participant_occupation", :name => "participant[occupation]"
      assert_select "input#participant_introducer", :name => "participant[introducer]"
      assert_select "input#participant_guarantor", :name => "participant[guarantor]"
      assert_select "input#participant_address", :name => "participant[address]"
      assert_select "input#participant_tel", :name => "participant[tel]"
      assert_select "input#participant_missionary", :name => "participant[missionary]"
      assert_select "input#participant_remark", :name => "participant[remark]"
      assert_select "input#participant_donation", :name => "participant[donation]"
      assert_select "input#participant_batch_id", :name => "participant[batch_id]"
      assert_select "input#participant_blessing_id", :name => "participant[blessing_id]"
    end
  end
end
