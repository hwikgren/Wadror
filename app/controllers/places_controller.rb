class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      session[:city] = params[:city]
      render :index
    end
  end
  
  def show
    places = Rails.cache.read(session[:city])
    places.each do |p|
      if p.id == params[:id]
        @place = p
        break
      end
    end
    #@place = places.select { |p| p.id == params[:id] }
  end
end
