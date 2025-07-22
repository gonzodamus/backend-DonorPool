require 'rails_helper'

RSpec.describe 'API Integration', type: :request do
  describe 'Users API' do
    describe 'GET /users' do
      it 'returns all users' do
        create_list(:user, 3)
        get '/users'
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).length).to eq(3)
      end
    end

    describe 'POST /users' do
      let(:valid_params) do
        {
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@example.com',
          password: 'password123'
        }
      end

      it 'creates a new user' do
        expect {
          post '/users', params: valid_params
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'Charities API' do
    describe 'GET /charities' do
      it 'returns all charities' do
        create_list(:charity, 2)
        get '/charities'
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).length).to eq(2)
      end
    end

    describe 'GET /charities/:id' do
      let(:charity) { create(:charity) }

      it 'returns the charity' do
        get "/charities/#{charity.id}"
        expect(response).to have_http_status(200)
        response_body = JSON.parse(response.body)
        expect(response_body['id']).to eq(charity.id)
      end
    end
  end
end