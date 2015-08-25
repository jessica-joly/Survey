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

  it 'update the title of the survey' do
    survey = Survey.create({:title => "title"})
    visit "/surveys/#{survey.id}"
    click_link 'Update Survey'
    fill_in 'title', with: "Booboo"
    click_button 'Submit'
    expect(page).to have_content "Booboo"
  end

  it 'deletes the survey' do
    survey = Survey.create({:title => "title"})
    visit "/surveys/#{survey.id}"
    click_link 'Update Survey'
    click_button 'Delete'
    expect(page).not_to have_content "title"
    expect(page).to have_content 'Survey'
  end

  it 'capitalizes survey titles' do
    survey = Survey.create({ title: 'hi' })
    visit "/surveys/#{survey.id}"
    expect(page).to have_content 'Hi'
  end

  it "deletes a survey from the index page" do
    survey = Survey.create({ title: 'hi' })
    visit '/'
    click_link 'delete'
    expect(page).not_to have_content 'Hi'
  end
end

describe 'questions path', { type: :feature } do
  it 'updates a question' do
    survey = Survey.create({ title: 'hi' })
    question = Question.create({query: "cheese?", survey_id: survey.id })
    visit "/surveys/#{survey.id}"
    click_link "#{question.query}"
    fill_in 'query', with: 'do you like ice cream?'
    click_button 'Submit Question'
    expect(page).to have_content 'do you like ice cream?'
  end

  it 'delete a question' do
    survey = Survey.create({ title: 'hi' })
    question = Question.create({query: "cheese?", survey_id: survey.id })
    visit "/surveys/#{survey.id}"
    click_link "#{question.query}"
    click_button 'Delete'
    expect(page).not_to have_content 'cheese?'
  end

  it 'adds a response to a question' do
    survey = Survey.create({ title: 'hi' })
    question = Question.create({query: "cheese?", survey_id: survey.id })
    visit "/surveys/#{survey.id}"
    click_link "#{question.query}"
    fill_in 'reply', with: "reply"
    click_button "Submit Response"
    expect(page).to have_content "reply"
  end
end
