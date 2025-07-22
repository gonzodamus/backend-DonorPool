require 'rails_helper'

RSpec.describe CharitiesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all charities' do
      charities = create_list(:charity, 3)
      get :index
      expect(assigns(:charities)).to match_array(charities)
    end

    it 'returns JSON format' do
      get :index
      expect(response.content_type).to include('application/json')
    end
  end

  describe 'GET #show' do
    let(:charity) { create(:charity) }

    context 'when charity exists' do
      it 'returns a successful response' do
        get :show, params: { id: charity.id }
        expect(response).to be_successful
      end

      it 'returns the charity data' do
        get :show, params: { id: charity.id }
        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq(charity.id)
      end
    end

    context 'when charity does not exist' do
      it 'returns a successful response with nil' do
        get :show, params: { id: 999 }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    let(:charity) { create(:charity) }
    let(:valid_params) do
      {
        id: charity.id,
        name: 'Updated Charity Name',
        tagline: 'New tagline',
        URL: 'http://example.com',
        mission: 'Updated mission'
      }
    end

    context 'with valid parameters' do
      it 'updates the charity' do
        patch :update, params: valid_params
        charity.reload
        expect(charity.name).to eq('Updated Charity Name')
      end

      it 'returns a successful response' do
        patch :update, params: valid_params
        expect(response).to be_successful
      end

      it 'returns the updated charity' do
        patch :update, params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to eq('Updated Charity Name')
      end
    end

    context 'when charity does not exist' do
      it 'returns an error' do
        patch :update, params: { id: 999, name: 'Test' }
        expect(response).to have_http_status(500)
      end
    end
  end
end