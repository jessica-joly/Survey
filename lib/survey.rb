class Survey < ActiveRecord::Base
  has_many :questions
  validates(:title, {:presence => true, :length => {:maximum => 50}})

  before_save :upcase_title

  def upcase_title
    self.title = self.title.capitalize
  end

end
