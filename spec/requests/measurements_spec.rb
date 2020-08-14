require 'rails_helper'

RSpec.describe 'Measurements API' do
  let(:user) { create(:user) }
  let!(:step) { create(:step, day_recorded: '2015-11-11') }
  let!(:measurements) { create_list(:measurement, 20, step_id: step.id) }
  let(:step_id) { step.id }
  let(:id) { measurements.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /steps/:step_id/measurements
  describe 'GET /steps/:step_id/measurements' do
    before { get "/steps/#{step_id}/measurements", params: {}, headers: headers }

    context 'when step exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all step measurements' do
        expect(json.size).to eq(20)
      end
    end

    context 'when step does not exist' do
      let(:step_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find step/)
      # end
    end
  end

  # Test suite for GET /steps/:step_id/measurements/:id
  describe 'GET /steps/:step_id/measurements/:id' do
    before { get "/steps/#{step_id}/measurements/#{id}", params: {}, headers: headers }

    context 'when step measurement exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the measurement' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when step measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find measurement/)
      # end
    end
  end

  # Test suite for PUT /steps/:step_id/measurements
  describe 'POST /steps/:step_id/measurements' do
    let(:valid_attributes) { { steps_recorded: 1500 }.to_json }

    context 'when request attributes are valid' do
      before do
         post "/steps/#{step_id}/measurements", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/steps/#{step_id}/measurements", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Steps recorded can't be blank/)
      end
    end
  end

  # Test suite for PUT /steps/:step_id/measurements/:id
  describe 'PUT /steps/:step_id/measurements/:id' do
    let(:valid_attributes) { { steps_recorded: 2000 }.to_json }

    before do
      put "/steps/#{step_id}/measurements/#{id}", params: valid_attributes,  headers: headers
    end

    context 'when measurement exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the measurement' do
        updated_measurement = Measurement.find(id)
        expect(updated_measurement.steps_recorded).to match(2000)
      end
    end

    context 'when the measurement does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find measurement/)
      # end
    end
  end

  # Test suite for DELETE /steps/:id
  describe 'DELETE /steps/:id' do
    before { delete "/steps/#{step_id}/measurements/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end