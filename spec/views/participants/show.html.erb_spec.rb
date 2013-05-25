require 'spec_helper'

describe "participants/show" do
  before(:each) do
    @participant = assign(:participant, stub_model(Participant,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sex/)
    rendered.should match(/Name/)
    rendered.should match(/Age/)
    rendered.should match(/Occupation/)
    rendered.should match(/Introducer/)
    rendered.should match(/Guarantor/)
    rendered.should match(/Address/)
    rendered.should match(/Tel/)
    rendered.should match(/Missionary/)
    rendered.should match(/Remark/)
    rendered.should match(/Donation/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
