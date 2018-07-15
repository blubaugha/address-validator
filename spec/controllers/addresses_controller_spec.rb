require 'rails_helper'

RSpec.describe AddressesController, :type => :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) {
        {
            street_address: '1600 Pennsylvania Avenue NW',
            city: 'Washington',
            state: 'DC',
            zip_code: '20500'
        }
      }
      let(:verified_address) {
        [
            {
                input_index: 0,
                components: {
                    primary_number: '1600',
                    street_predirection: '',
                    street_postdirection: 'NW',
                    street_name: 'Pennsylvania',
                    street_suffix: 'Avenue',
                    city_name: 'Washington',
                    state_abbreviation: 'DC',
                    zipcode: '20500',
                    plus4_code: '0003'
                }
            }
        ]
      }
      before do
        stub_request(:get, /us-street.api.smartystreets.com/)
            .to_return(status: 200, body: verified_address.to_json, headers: {})

        post 'create', params: valid_params
      end
      it 'creates a new address model with the house number saved' do
        expect(assigns(:address).house_number).to eq '1600'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).street_name).to eq 'Pennsylvania'
      end

      it 'creates a new address model with the street name saved' do
        expect(assigns(:address).street_type).to eq 'Avenue'
      end

      it 'creates a new address model with the street post direction saved' do
        expect(assigns(:address).street_postdirection).to eq 'NW'
      end

      it 'creates a new address model with the city saved' do
        expect(assigns(:address).city).to eq 'Washington'
      end

      it 'creates a new address model with the state saved' do
        expect(assigns(:address).state).to eq 'DC'
      end

      it 'creates a new address model with the zip_5 saved' do
        expect(assigns(:address).zip_5).to eq '20500'
      end

      it 'creates a new address model with the zip_4 saved' do
        expect(assigns(:address).zip_4).to eq '0003'
      end
    end

    context 'with invalid params' do
      let(:invalid_params) {
        {
            street_address: '1600 Pennsylvania Avenue NW'
        }
      }

      before do
        stub_request(:get, /us-street.api.smartystreets.com/)
            .to_return(status: 200, body: [].to_json, headers: {})

        post 'create', params: invalid_params
      end

      it 'creates an invalid address model when the parameters are not valid' do
        expect(assigns(:address).valid?).to eq false
      end
    end
  end
end
