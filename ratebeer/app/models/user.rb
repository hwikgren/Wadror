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
end
