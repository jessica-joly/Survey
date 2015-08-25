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

  it 'can add questions to a survey' do
    survey = Survey.create({:title => "title"})
    visit "/surveys/#{survey.id}"
    fill_in 'query', with: 'Do you like cheese?'
    click_button 'Submit'
    expect(page).to have_content "Do you like cheese?"
  end
end
