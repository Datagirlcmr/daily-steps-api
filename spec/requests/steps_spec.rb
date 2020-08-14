require 'rails_helper'

RSpec.describe 'Steps API', type: :request do
  # add todos owner
  let(:user) { create(:user) }
  let!(:steps) { create_list(:step, 10, day_recorded: '2015-11-11') }
  let(:step_id) { steps.first.id }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /steps' do
    # update request with headers
    before { get '/steps' , params: {}, headers: headers }

    it 'returns steps' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /steps/:id
  describe 'GET /steps/:id' do
    before { get "/steps/#{step_id}" , params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the step' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(step_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:step_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    #   it 'returns a not found message' do
    #     expect(response.body).to match(/Couldn't find step/)
    #   end
    end
  end

  # Test suite for POST /steps
  describe 'POST /steps' do
    # valid payload
    let(:valid_attributes) do
      { title: 'Learn Elm', day_recorded: Date.today }.to_json
    end

    context 'when the request is valid' do
      before { post '/steps', params: valid_attributes, headers: headers }

      it 'creates a step' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/steps', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    #   it 'returns a validation failure message' do
    #     expect(response.body)
    #       .to match(/Validation failed: Created by can't be blank/)
    #   end
    end
  end

  # Test suite for PUT /steps/:id
  describe 'PUT /steps/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/steps/#{step_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /steps/:id
  describe 'DELETE /steps/:id' do
    before { delete "/steps/#{step_id}" , params: {}, headers: headers  }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end