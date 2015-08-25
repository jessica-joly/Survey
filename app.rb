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
