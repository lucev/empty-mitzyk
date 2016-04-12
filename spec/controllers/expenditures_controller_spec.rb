require 'rails_helper'
require 'date'

describe ExpendituresController do

  let(:user) { FactoryGirl.create :user }
  let(:expenditure) { FactoryGirl.create :expenditure, user: user }

  def valid_attributes
    { amount: '3.99', date: Date.today.to_s }
  end

  def invalid_attributes
    { amount: nil, date: nil }
  end

  before { sign_in user }

  describe "GET index" do
    it "assigns all expenditures as @expenditures" do
      get :index, {}

      assigns(:expenditures).should eq([expenditure])
    end
  end

  describe "GET show" do
    it "assigns the requested expenditure as @expenditure" do
      get :show, {:id => expenditure.to_param}

      assigns(:expenditure).should eq(expenditure)
    end
  end

  describe "GET new" do
    it "assigns a new expenditure as @expenditure" do
      get :new, {}
      assigns(:expenditure).should be_a_new(Expenditure)
    end
  end

  describe "GET edit" do
    it "assigns the requested expenditure as @expenditure" do
      get :edit, {:id => expenditure.to_param}

      assigns(:expenditure).should eq(expenditure)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Expenditure" do
        expect {
          post :create, {:expenditure => valid_attributes}
        }.to change(Expenditure, :count).by(1)
      end

      it "assigns a newly created expenditure as @expenditure" do
        post :create, {:expenditure => valid_attributes}
        assigns(:expenditure).should be_a(Expenditure)
        assigns(:expenditure).should be_persisted
      end

      it "redirects to home page" do
        post :create, {:expenditure => valid_attributes}
        response.should redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expenditure as @expenditure" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expenditure.any_instance.stub(:save).and_return(false)
        post :create, {:expenditure => invalid_attributes }
        assigns(:expenditure).should be_a_new(Expenditure)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expenditure.any_instance.stub(:save).and_return(false)
        post :create, {:expenditure => invalid_attributes }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested expenditure" do
        # Assuming there are no other expenditures in the database, this
        # specifies that the Expenditure created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Expenditure.any_instance.should_receive(:update_attributes).with(valid_attributes.stringify_keys)

        put :update, {:id => expenditure.to_param, :expenditure => valid_attributes }
      end

      it "assigns the requested expenditure as @expenditure" do
        put :update, {:id => expenditure.to_param, :expenditure => valid_attributes}

        assigns(:expenditure).should eq(expenditure)
      end

      it "redirects to the expenditure" do
        put :update, {:id => expenditure.to_param, :expenditure => valid_attributes}

        response.should redirect_to(expenditure)
      end
    end

    describe "with invalid params" do
      it "assigns the expenditure as @expenditure" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expenditure.any_instance.stub(:save).and_return(false)
        put :update, {:id => expenditure.to_param, expenditure: invalid_attributes }

        assigns(:expenditure).should eq(expenditure)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Expenditure.any_instance.stub(:save).and_return(false)
        put :update, {:id => expenditure.to_param, expenditure: invalid_attributes }

        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:expenditure) { FactoryGirl.create(:expenditure, user: user) }
    it "destroys the requested expenditure" do
      expect {
        delete :destroy, {:id => expenditure.to_param}
      }.to change(Expenditure, :count).by(-1)
    end

    it "redirects to the expenditures list" do
      delete :destroy, {:id => expenditure.to_param}

      response.should redirect_to(expenditures_url)
    end
  end

end
