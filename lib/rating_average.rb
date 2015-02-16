module RatingAverage
  def average_rating
    if ratings.empty?
      return 0
    end
    return ratings.average(:score).round(2)
  end
end
