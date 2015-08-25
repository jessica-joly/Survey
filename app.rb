require 'sinatra/activerecord'
require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require 'pry'
require './lib/question'
require './lib/survey'
require './lib/inquiry'
require './lib/user'
require './lib/answer'


get '/'  do
	erb :index
end

get '/users/new' do
	erb :user_form
end

post '/users' do
	if  params['name'] != ''
		@user = User.create({ name: params['name'] })
		redirect "/users/#{@user.id}/surveys"
  else
		redirect '/users/new'
	end
end

get '/users/:id/surveys' do
	@user = User.find(params['id'].to_i)
  erb :user_surveys
end

get '/users/:id/surveys/:survey_id' do
	@user = User.find(params['id'].to_i)
  @survey = Survey.find(params['survey_id'].to_i)
	redirect "users/#{@user.id}/surveys/#{@survey.id}/questions/#{@survey.questions.first.id}"
end

get '/users/:id/surveys/:survey_id/questions/:question_id' do
	@user = User.find(params['id'].to_i)
	@survey = Survey.find(params['survey_id'].to_i)
	@question = Question.find(params['question_id'].to_i)
	@replies = @question.inquiries
  erb :reply_form
end


get '/surveys' do
	erb :surveys
end

get '/surveys/new'do
  erb :survey_form
end

post '/surveys' do
	@survey = Survey.create({ title: params['title'] })
	redirect "/surveys"
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

delete '/questions/:id' do
	@question = Question.find(params['id'].to_i)
	@survey = Survey.find(@question.survey_id)
	@question.destroy
	redirect "/surveys/#{@survey.id}"
end

get '/delete/:id' do
  @survey = Survey.find(params['id'].to_i)
	@survey.destroy
	redirect "/"
end

post '/inquiries' do
	@question = Question.find(params['question_id'].to_i)
	@reply = Inquiry.create({ reply: params['reply'], question_id: params['question_id'].to_i })
	redirect "/questions/#{@reply.question_id}/edit"
end
