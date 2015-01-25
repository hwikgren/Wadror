class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  def to_s
    #beer = Beer.find self.beer_id
    "#{beer.name} #{self.score}"
  end
end
