require 'rails_helper'
require 'date'

describe ExpendituresController, type: :controller do

  let(:user) { FactoryBot.create :user }
  let(:category) { FactoryBot.create :category }
  let(:expenditure) { FactoryBot.create :expenditure, user: user }

  def valid_attributes
    { amount: '3.99', date: Date.today.to_s, category_id: category.id}
  end

  def invalid_attributes
    { amount: nil, date: nil }
  end

  before { sign_in user }

  describe 'GET index' do
    subject { get :index }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns all expenditures as @expenditures' do
      subject
      expect(assigns(:expenditures)).to eq([expenditure])
    end
  end

  describe 'GET show' do
    subject { get :show, params: { id: expenditure.to_param } }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns the requested expenditure as @expenditure' do
      subject
      expect(assigns(:expenditure)).to eq(expenditure)
    end
  end

  describe 'GET new' do
    subject { get :new, {} }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assgns a new expenditure as @expenditure' do
      subject
      expect(assigns(:expenditure)).to be_a_new(Expenditure)
    end
  end

  describe 'GET edit' do
    subject { get :edit, params: { id: expenditure.to_param } }

    it 'returns http 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'assigns the requested expenditure as @expenditure' do
      subject
      assigns(:expenditure).should eq(expenditure)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      subject { post :create, params: { expenditure: valid_attributes } }

      it 'returns http 302' do
        subject
        expect(response).to have_http_status(302)
      end
      it 'redirects to home page' do
        subject
        expect(response).to redirect_to(root_path)
      end
      it 'creates a new Expenditure' do
        expect { subject }.to change(Expenditure, :count).by(1)
      end
      it 'assigns a newly created expenditure as @expenditure' do
        subject
        expect(assigns(:expenditure)).to be_a(Expenditure)
        expect(assigns(:expenditure)).to be_persisted
      end
    end

    context 'with invalid params' do
      subject { post :create, params: { expenditure: invalid_attributes } }

      it 'returns http 422' do
        subject
        expect(response).to have_http_status(422)
      end
      it 're-renders the new template' do
        subject
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
   context 'with valid params' do
      subject { put :update, params: { id: expenditure.to_param, expenditure: valid_attributes } }

      it 'assigns the requested expenditure as @expenditure' do
        subject
        expect(assigns(:expenditure)).to eq(expenditure)
      end
      it 'returns http 302' do
        subject
        expect(response).to have_http_status(302)
      end
      it 'redirects to the expenditure' do
        subject
        expect(response).to redirect_to(expenditure)
      end
    end

    context 'with invalid params' do
      subject { put :update, params: { id: expenditure.to_param, expenditure: invalid_attributes } }

      it 'returns http 422' do
        subject
        expect(response).to have_http_status(422)
      end
      it 're-renders the edit template' do
        subject
        response.should render_template("edit")
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:expenditure) { FactoryBot.create :expenditure, user: user }

    subject { delete :destroy, params: { id: expenditure.to_param } }
    it 'destroys the requested expenditure' do
      expect { subject }.to change(Expenditure, :count).by(-1)
    end
    it 'returns http 302' do
      subject
      expect(response).to have_http_status(302)
    end
    it 'redirects to the expenditures list' do
      subject
      expect(response).to redirect_to(expenditures_url)
    end
  end
end
