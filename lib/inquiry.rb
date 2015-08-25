class Inquiry < ActiveRecord::Base
  belongs_to :questions
  validates(:reply, {:presence => true, :length => {:maximum => 50}})
end
