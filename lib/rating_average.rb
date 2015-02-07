module RatingAverage
  def average_rating
    return ratings.average(:score).round(2)
  end
end
