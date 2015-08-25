ENV['RACK_ENV'] = 'test'
require 'sinatra/activerecord'
require 'rspec'
require 'pg'

require './lib/survey'
require './lib/question'

RSpec.configure do |config|
  config.after(:each) do
    Question.all.each do |task|
      task.destroy
    end
    Survey.all.each do |task|
      task.destroy
    end
  end
end
