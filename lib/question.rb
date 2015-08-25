class Question < ActiveRecord::Base
  has_many :inquiries
  belongs_to :surveys

end
