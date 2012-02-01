require 'spec_helper'

describe "expenditures/new" do
  before(:each) do
    assign(:expenditure, stub_model(Expenditure,
      :amount => "",
      :category_id => 1,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new expenditure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => expenditures_path, :method => "post" do
      assert_select "input#expenditure_amount", :name => "expenditure[amount]"
      assert_select "input#expenditure_category_id", :name => "expenditure[category_id]"
      assert_select "input#expenditure_description", :name => "expenditure[description]"
    end
  end
end
