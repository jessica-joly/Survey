require 'capybara/rspec'
require './app'
require 'spec_helper'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'survey path', { type: :feature } do
  it 'can add a new survey' do
    visit '/'
    click_link 'Add Survey'
    fill_in 'title', with: 'Election'
    click_button 'Submit'
    expect(page).to have_content "Election"
  end
end
