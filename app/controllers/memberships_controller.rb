class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.where.not(id: current_user.beer_clubs)
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id
    respond_to do |format|
      if @membership.save
        @membership.update_attribute(:confirmed, false)
        format.html { redirect_to @membership.beer_club, notice: "#{current_user.username}, your application has been sent!" }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    beer_club = @membership.beer_club
    respond_to do |format|
      if @membership.destroy      
        format.html { redirect_to current_user, notice: "Membership in #{beer_club.name} ended." }
        format.json { head :no_content }
      else
        redirect_to back
      end
    end
  end

  def confirm_application
    membership = Membership.where(beer_club_id: params[:beer_club_id], user_id: params[:user_id]).take
    membership.update_attribute(:confirmed, true)
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :beer_club_id)
    end
end
