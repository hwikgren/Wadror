class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :style_id, presence: true

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    return "#{self.name} - #{self.brewery.name}"
  end

  def self.top_beers(n)
    Beer.all.sort_by{ |b| -(b.average_rating) }.take(n)
  end
end
