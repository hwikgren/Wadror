class RatingsController < ApplicationController
  def index
    @ratings = Rating.recent
    @top_beers = Beer.top_beers(3)
    @top_breweries = Brewery.top_breweries 3
    @top_users = User.top_raters(3)
    @top_styles = Style.top_styles(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    if @rating.save 
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end
