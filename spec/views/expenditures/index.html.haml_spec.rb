require 'spec_helper'
require 'date'

describe "expenditures/index" do
  before(:each) do
    assign(:expenditures, [
      stub_model(Expenditure,
        :amount => 3.99,
        :date => Date.today,
        :category_id => 1,
        :description => "Description"
      ),
      stub_model(Expenditure,
        :amount => 5.49,
        :date => Date.today,
        :category_id => 1,
        :description => "Description"
      )
    ])
    assign(:range_start,
      Date.today - Date.today.mday + 1
    )
    assign(:range_end,
      Date.today
    )
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
