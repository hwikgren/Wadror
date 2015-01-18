class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = 0
    count = 0.0
    self.ratings.each do |rating|
      sum = sum + rating.score
      count += 1
    end
    return (sum/count).round(1)
  end
end
