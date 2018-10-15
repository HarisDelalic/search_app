require 'rails_helper'

RSpec.describe Search, type: :model do
  describe '#valid' do
    context 'search query param' do
      it 'should not save when nil' do
        search_without_query = build :search, ip: '0.0.0.0.', query: nil
        expect(search_without_query).to_not be_valid
        expect(search_without_query.save).to be false
      end
      it 'should not save when too short' do
        search_without_query = build :search, ip: '0.0.0.0.', query: 'ab'
        expect(search_without_query).to_not be_valid
        expect(search_without_query.save).to be false
      end
    end
    context 'search ip param' do
      it 'should not save when nil' do
        search_without_query = build :search, ip: nil, query: 'How do I'
        expect(search_without_query).to_not be_valid
        expect(search_without_query.save).to be false
      end
    end
  end
end