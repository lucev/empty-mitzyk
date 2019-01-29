require 'rails_helper'

describe CategoriesController do

  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, user: user) }

  def valid_attributes
    { name: 'transportation', position: '1'}
  end
  
  def invalid_attributes
    { name: '', position: nil }
  end

  before { sign_in user }

  describe 'GET index' do
    subject { get :index }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns all categories as @categories' do
      subject
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET show' do
    subject { get :show, params: { id: category.to_param } }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns the requested category as @category' do
      subject
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'GET new' do
    subject { get :new }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns a new category as @category' do
      subject
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'GET edit' do
    subject { get :edit, params: { id: category.to_param } }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns the requested category as @category' do
      subject
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      subject { post :create, params: { category: valid_attributes } }

      it 'creates a new Category' do
        expect { subject }.to change(Category, :count).by(1)
      end
      it 'assigns a newly created category as @category' do
        subject
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end
      it 'returns http 302' do
        subject
        expect(response).to have_http_status(302)
      end
      it 'redirects to the created category' do
        subject
        expect(response).to redirect_to(Category.last)
      end
    end

    context 'with invalid params' do
      subject { post :create, params: { category: invalid_attributes } }

      it 'returns http 422' do
        subject
        expect(response).to have_http_status(422)
      end
      it 're-renders the new template' do
        subject
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    let!(:category) { FactoryBot.create(:category, user: user, name: 'travel' ) }

    describe 'with valid params' do
      subject { put :update, params: { id: category.to_param, category: valid_attributes } }

      it 'updates the requested category' do
        subject
        expect(category.reload.name).to eq 'transportation'
      end
      it 'assigns the requested category as @category' do
        subject
        expect(assigns(:category)).to eq(category)
      end
      it 'returns http 302' do
        subject
        expect(response).to have_http_status(302)
      end
      it 'redirects to the category' do
        subject
        expect(response).to redirect_to(category)
      end
    end

    describe 'with invalid params' do
      subject { put :update, params: { id: category.to_param, category: invalid_attributes } }

      it 'returns http 422' do
        subject
        expect(response).to have_http_status(422)
      end
      it 're-renders the edit template' do
        subject
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:category) { FactoryBot.create(:category, user: user) }

    subject { delete :destroy, params: { id: category.to_param } }

    it 'destroys the requested category' do
      expect { subject }.to change(Category, :count).by(-1)
    end
    it 'returns http 302' do
      subject
      expect(response).to have_http_status(302)
    end
    it 'redirects to the categories list' do
      subject
      response.should redirect_to(categories_url)
    end
  end
end
