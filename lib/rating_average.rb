module RatingAverage
  def average_rating
    if ratings.empty?
      return 0
    end
    return ratings.average(:score)
  end
end
