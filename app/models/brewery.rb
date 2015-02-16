class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validate :acceptable_year

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil, false] }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end

  def acceptable_year
    unless year.present? && year >= 1042 && year <= Time.now.year
      errors.add(:year, "has to be present and between 1042 and this year")
    end
  end

  def self.top_breweries(n)
    Brewery.all.sort_by{ |b| -(b.average_rating) }.take(n)
  end
end

