require 'rails_helper'

describe CategoriesController do

  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, user: user) }

  def valid_attributes
    {:name => 'transportation', :position => '1'}
  end
  
  def invalid_attributes
    { name: '', position: nil }
  end

  before { sign_in user }

  describe "GET index" do
    it "assigns all categories as @categories" do
      get :index, {}

      assigns(:categories).should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      get :show, params: {:id => category.to_param}

      assigns(:category).should eq(category)
    end
  end

  describe "GET new" do
    it "assigns a new category as @category" do
      get :new, {}

      assigns(:category).should be_a_new(Category)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      get :edit, params: {:id => category.to_param}

      assigns(:category).should eq(category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {:category => valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, params: {:category => valid_attributes}

        assigns(:category).should be_a(Category)
        assigns(:category).should be_persisted
      end

      it "redirects to the created category" do
        post :create, params: {:category => valid_attributes}

        response.should redirect_to(Category.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, params: {:category => invalid_attributes }
        assigns(:category).should be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        post :create, params: {:category => invalid_attributes }
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested category" do
        # Assuming there are no other categories in the database, this
        # specifies that the Category created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Category.any_instance.should_receive(:update_attributes)
        put :update, params: {:id => category.to_param, :category => valid_attributes }
      end

      it "assigns the requested category as @category" do
        put :update, params: {:id => category.to_param, :category => valid_attributes}

        assigns(:category).should eq(category)
      end

      it "redirects to the category" do
        put :update, params: {:id => category.to_param, :category => valid_attributes}

        response.should redirect_to(category)
      end
    end

    describe "with invalid params" do
      it "assigns the category as @category" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => category.to_param, category: invalid_attributes }

        assigns(:category).should eq(category)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Category.any_instance.stub(:save).and_return(false)
        put :update, params: {:id => category.to_param, category: invalid_attributes }

        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:category) { FactoryBot.create(:category, user: user) }

    it "destroys the requested category" do
      expect {
        delete :destroy, params: {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      delete :destroy, params: {:id => category.to_param}
      response.should redirect_to(categories_url)
    end
  end

end
