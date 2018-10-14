require 'rails_helper'

RSpec.describe 'Searches managment' do
  let!(:search) { create(:search) }
  it 'User lists search items' do
    visit searches_path
    expect(page).to have_content(search.query)
    expect(page).to have_content(search.ip)
  end
end