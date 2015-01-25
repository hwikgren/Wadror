module RatingAverage
  def average_rating
    return ratings.average(:score)
  end
end
