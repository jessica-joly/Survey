require 'sinatra/activerecord'
require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require 'pry'
require './lib/question'
require './lib/survey'

get '/'  do
	erb :index
end

get '/surveys/new'do
  erb :survey_form
end

post '/surveys' do
	@survey = Survey.create({ title: params['title'] })
	redirect "/"
end

get '/surveys/:id' do
	@survey = Survey.find(params['id'].to_i)
	erb :survey
end

get '/surveys/:id/edit' do
	@survey = Survey.find(params['id'].to_i)
  erb :survey_edit
end

patch '/surveys/:id' do
  @survey = Survey.find(params['id'].to_i)
	@survey.update({ title: params['title'] })
	redirect "/surveys/#{@survey.id}"
end

delete '/surveys/:id' do
  @survey = Survey.find(params['id'].to_i)
	@survey.destroy
	redirect "/"
end

post '/questions' do
	@question = Question.create({ query: params['query'], survey_id: params['survey_id'] })
	redirect "surveys/#{@question.survey_id}"
end

get '/questions/:id/edit' do
  @question = Question.find(params['id'].to_i)
	erb :question_edit
end

patch '/questions/:id' do
  @question = Question.find(params['id'].to_i)
	@question.update({ query: params['query'] })
	redirect "surveys/#{@question.survey_id}"
end

get '/delete/:id' do
  @survey = Survey.find(params['id'].to_i)
	@survey.destroy
	redirect "/"
end
