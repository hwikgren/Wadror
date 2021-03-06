class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :ensure_that_admin, only: [:delete]
  before_action :skip_if_cached, only: [:index]
  before_action :expire_fragments, only: [:create, :update, :destroy]

  # GET /breweries
  # GET /breweries.json
  def index
    case @order
      when 'name' 
        @active_breweries = Brewery.active.order('lower(name)')
        @retired_breweries = Brewery.retired.order('lower(name)')
        session[:brewery_order] = "name"
      when 'year'
        if session[:brewery_order] == "year_down"
          @active_breweries = Brewery.active.order(:year).reverse
          @retired_breweries = Brewery.retired.order(:year).reverse
          session[:brewery_order] = "year_up"
        else
          @active_breweries = Brewery.active.order(:year)
          @retired_breweries = Brewery.retired.order(:year)
          session[:brewery_order] = "year_down"
        end
    end
    @breweries = Brewery.all    
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)
    new_status = brewery.active? ? "active" : "retired"
    redirect_to :back, notice:"Brewry activity status changed to #{new_status}"
  end

  def brewerylist
  end

  def ngbreweries
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    def skip_if_cached
      @order = params[:order] || 'name'
        if fragment_exist?("breweries-#{@order}")
          return render :index 
        end
    end

    def expire_fragments
        ["breweries-name", "breweries-year"].each{ |f| expire_fragment(f) }
        session[:brewery_order] = ""
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end

end
