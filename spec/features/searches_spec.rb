require 'rails_helper'

RSpec.describe 'Searches managment', type: :feature do

  scenario 'User lists search items' do
    search = create :search
    visit searches_path
    expect(page).to have_content(search.query)
    expect(page).to have_content(search.ip)
  end

  scenario 'User creates search item and see it on page' do
    search = build :search
    visit searches_path
    fill_in 'search_field', with: search.query
    click_button 'Search'
    expect(page).to have_content(search.query)
  end
end