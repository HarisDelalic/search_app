require 'rails_helper'

RSpec.describe 'Searches managment' do
  let(:search) { create(:search, query: 'How to', ip: '170.170.170.170') }
  it 'User lists search items' do
    visit searches_path
    expect(page).to have_content('How to')
    expect(page).to have_content('170.170.170.170')
  end
end