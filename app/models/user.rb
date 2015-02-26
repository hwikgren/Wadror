class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }, format: { with: /\A(.*[A-Z].*)(.*\d.*)|(.*\d.*)(.*[A-Z].*)\z/, 
    message: "has to contain at least one uppercase letter and one number" }

  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
#    ratings.order(score: :desc).limit(1).first.beer
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return nil if ratings.empty?
    beers.group(:style).average(:score).max_by{ |k,v| v }[0].name
  end

  def favorite_brewery
    return nil if ratings.empty?
    brewery_id = beers.group(:brewery_id).average(:score).max_by{ |k,v| v}[0]
    Brewery.find(brewery_id).name
  end

  def self.top_raters(n)
    Rating.group(:user_id).count.sort_by{ | k, v| v}.reverse.map{ |row| row[0] }.map{ |user| User.find(user) }
  end
end
