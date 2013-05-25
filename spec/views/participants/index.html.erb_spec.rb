require 'spec_helper'

describe "participants/index" do
  before(:each) do
    assign(:participants, [
      stub_model(Participant,
        :sex => "Sex",
        :name => "Name",
        :age => "Age",
        :occupation => "Occupation",
        :introducer => "Introducer",
        :guarantor => "Guarantor",
        :address => "Address",
        :tel => "Tel",
        :missionary => "Missionary",
        :remark => "Remark",
        :donation => "Donation",
        :batch_id => 1,
        :blessing_id => 2
      ),
      stub_model(Participant,
        :sex => "Sex",
        :name => "Name",
        :age => "Age",
        :occupation => "Occupation",
        :introducer => "Introducer",
        :guarantor => "Guarantor",
        :address => "Address",
        :tel => "Tel",
        :missionary => "Missionary",
        :remark => "Remark",
        :donation => "Donation",
        :batch_id => 1,
        :blessing_id => 2
      )
    ])
  end

  it "renders a list of participants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Age".to_s, :count => 2
    assert_select "tr>td", :text => "Occupation".to_s, :count => 2
    assert_select "tr>td", :text => "Introducer".to_s, :count => 2
    assert_select "tr>td", :text => "Guarantor".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Tel".to_s, :count => 2
    assert_select "tr>td", :text => "Missionary".to_s, :count => 2
    assert_select "tr>td", :text => "Remark".to_s, :count => 2
    assert_select "tr>td", :text => "Donation".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
