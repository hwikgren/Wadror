class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    return self.ratings.average(:score)
  end

  def to_s
    return "#{self.name} - #{self.brewery.name}"
  end
end
