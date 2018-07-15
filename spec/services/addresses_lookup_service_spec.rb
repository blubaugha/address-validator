require 'rails_helper'

RSpec.describe AddressLookupService do
  describe '#lookup' do
    context 'with a match' do
      let(:verified_address) {
        [
            {
                input_index: 0,
                components: {
                    primary_number: '1600',
                    street_predirection: 'S',
                    street_postdirection: 'NW',
                    street_name: 'Pennsylvania',
                    street_suffix: 'Avenue',
                    city_name: 'Washington',
                    secondary_number: '1',
                    secondary_designator: 'Apt',
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

        address = Address.new(street_address: '1600 S Pennsylvania Avenue NW',
                              city: 'Washington',
                              state: 'DC',
                              zip_code: '20500')
        @lookup_service = AddressLookupService.new(address)
        @verified_address = @lookup_service.lookup
      end

      it 'finds the house number' do
        expect(@verified_address[:house_number]).to eq('1600')
      end

      it 'finds the street name' do
        expect(@verified_address[:street_name]).to eq('Pennsylvania')
      end

      it 'finds the street type' do
        expect(@verified_address[:street_type]).to eq('Avenue')
      end

      it 'finds the pre-direction' do
        expect(@verified_address[:street_predirection]).to eq('S')
      end

      it 'finds the post-direction' do
        expect(@verified_address[:street_postdirection]).to eq('NW')
      end

      it 'finds the unit number' do
        expect(@verified_address[:unit_number]).to eq('1')
      end

      it 'finds the unit type' do
        expect(@verified_address[:unit_type]).to eq('Apt')
      end

      it 'finds the city' do
        expect(@verified_address[:city]).to eq('Washington')
      end

      it 'finds the state' do
        expect(@verified_address[:state]).to eq('DC')
      end

      it 'finds the 5-digit zip code' do
        expect(@verified_address[:zip_5]).to eq('20500')
      end

      it 'finds the 4-digit zip code extension' do
        expect(@verified_address[:zip_4]).to eq('0003')
      end
    end
    context 'with no match' do
      before do
        stub_request(:get, /us-street.api.smartystreets.com/)
            .to_return(status: 200, body: [].to_json, headers: {})
      end

      it 'find nil when there is no match' do
        result = AddressLookupService.new(Address.new).lookup
        expect(result).to be_nil
      end
    end
    context 'with an error' do
      before do
        stub_request(:get, /us-street.api.smartystreets.com/)
            .to_return(status: 500, body: 'Something bad happened!', headers: {})
      end

      it 'find nil when there is an error response' do
        result = AddressLookupService.new(Address.new).lookup
        expect(result).to be_nil
      end
    end
  end
end
