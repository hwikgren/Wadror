class Rating < ActiveRecord::Base
  belongs_to :beer, touch: true
  belongs_to :user

  scope :recent, -> { order('updated_at DESC').limit(5) }
  
  validates :score, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 50, only_integer: true }
  def to_s
    #beer = Beer.find self.beer_id
    "#{beer.name} #{self.score}"
  end
end
