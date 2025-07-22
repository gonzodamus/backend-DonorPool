require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all users' do
      users = create_list(:user, 3)
      get :index
      expect(assigns(:users)).to match_array(users)
    end

    it 'returns JSON format' do
      get :index
      expect(response.content_type).to include('application/json')
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        first_name: 'John',
        last_name: 'Doe',
        email: 'john@example.com',
        password: 'password123'
      }
    end

    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns a successful response' do
        post :create, params: valid_params
        expect(response).to be_successful
      end

      it 'returns a token and user data' do
        post :create, params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('token')
        expect(json_response).to have_key('data')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error status' do
        post :create, params: { email: 'invalid' }
        expect(response).to have_http_status(401)
      end

      it 'returns an error message' do
        post :create, params: { email: 'invalid' }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('error')
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    context 'when user exists' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'returns a successful response' do
        get :show, params: { id: user.id }
        expect(response).to be_successful
      end

      it 'returns user data with token' do
        get :show, params: { id: user.id }
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('token')
        expect(json_response).to have_key('data')
      end
    end

    context 'when user does not exist' do
      it 'returns an error status' do
        get :show, params: { id: 999 }
        expect(response).to have_http_status(401)
      end
    end
  end
end