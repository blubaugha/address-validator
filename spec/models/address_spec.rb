require 'rails_helper'

RSpec.describe Address, :type => :model do
  describe '#new' do
    context 'Given a valid address' do
      it 'can create a new address' do
        expect(Address.new(
            house_number: 1600,
            street_name: 'Pennsylvania',
            street_type: 'Avenue',
            street_postdirection: 'NW',
            city: 'Washington',
            state: 'DC',
            zip_5: 20500
        )).to be_valid
      end
    end

    context 'Given bad address values' do
      it 'cannot create a new address' do
        expect(Address.new(
            house_number: 1600,
            street_name: 'Pennsylvania',
            street_type: 'Avenue',
            street_postdirection: 'NW',
            city: 'Washington',
            state: 'DC',
            zip_5: 123
        )).not_to be_valid
      end
    end

    describe '#to_s' do
      let(:address) {create(:address_ny)}
      it 'prints out the address components needed for mailing together as a string' do
        expect(address.to_s).to eq('129 W 81st St Apt 5A, New York, NY 10024')
      end

      it 'prints out the address components with no pre direction' do
        expect(Address.new(
            house_number: 129,
            street_name: '81st',
            street_type: 'St',
            unit_type: 'Apt',
            unit_number: '5A',
            city: 'New York',
            state: 'NY',
            zip_5: '10024').to_s).to eq('129 81st St Apt 5A, New York, NY 10024')
      end

      it 'prints out the address components with no street type' do
        expect(Address.new(
            house_number: 129,
            street_name: '81st',
            unit_type: 'Apt',
            unit_number: '5A',
            city: 'New York',
            state: 'NY',
            zip_5: '10024').to_s).to eq('129 81st Apt 5A, New York, NY 10024')
      end

      it 'prints out the address components with no unit' do
        expect(Address.new(
            house_number: 129,
            street_name: '81st',
            street_type: 'St',
            city: 'New York',
            state: 'NY',
            zip_5: '10024').to_s).to eq('129 81st St, New York, NY 10024')
      end

      it 'prints out the address components with no street type' do
        expect(Address.new(
            house_number: 129,
            street_name: '81st',
            city: 'New York',
            state: 'NY',
            zip_5: '10024').to_s).to eq('129 81st, New York, NY 10024')
      end
    end
  end
end
