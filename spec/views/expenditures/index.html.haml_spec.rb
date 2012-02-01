require 'spec_helper'

describe "expenditures/index" do
  before(:each) do
    assign(:expenditures, [
      stub_model(Expenditure,
        :amount => "",
        :category_id => 1,
        :description => "Description"
      ),
      stub_model(Expenditure,
        :amount => "",
        :category_id => 1,
        :description => "Description"
      )
    ])
  end

  it "renders a list of expenditures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
