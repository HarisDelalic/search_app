require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe 'POST #create' do

    let(:ip) { '0.0.0.0' }
    let(:contained_search_query) { 'How do I' }
    let(:valid_query) { 'How do I fix bicycle' }

    let(:contained_search_params) do
      { ip: ip, query: contained_search_query }
    end

    let(:valid_search_params) do
      { ip: ip, query: valid_query }
    end

    it 'user creates search' do
      expect do
        post :create, params: { search: valid_search_params }
      end.to change(Search, :count).by(1)
    end

    context 'when new search query is already contained in existing search query, both from same IP' do
      it 'new search query is not saved' do
        existing_search = create(:search, valid_search_params )
        expect do
          post :create, params: { search: contained_search_params }
        end.to_not change(Search, :count)
      end
    end

    context 'when search model exists where query is contained in new search query' do
      it 'new search query is saved, existing search is destroyed' do
        existing_search = create(:search, contained_search_params)
        expect do
          post :create, params: { search: valid_search_params }
        end.not_to change(Search, :count)

        expect(Search.count).to eq(1)
        expect(Search.first.query).to eq(valid_search_params[:query])
      end
    end
  end
end