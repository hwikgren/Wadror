class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def self.top_styles(n)
    self.all.sort_by{ |style| -(style.average_rating) }.take(n)
  end
end
