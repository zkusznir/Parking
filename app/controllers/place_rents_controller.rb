class PlaceRentsController < ApplicationController
  before_action :place_rent, only: [:show, :edit]

  def index
    @place_rents = PlaceRent.all
  end

  def new
    @place_rent = PlaceRent.new(parking: parking)
    @cars = current_person.cars
  end

  def create
    @place_rent = PlaceRent.new(place_rent_params)
    @place_rent.parking = parking
    if @place_rent.save
      redirect_to @place_rent
      flash[:success] = 'Place Rent successfully created!'
    else
      render action: 'new'
    end
  end

  private

  def place_rent
    @place_rent ||= PlaceRent.find_by_id_or_identifier(params[:id])
  end

  def parking
    @parking ||= Parking.find(params[:parking_id])
  end

  def place_rent_params
    params.require(:place_rent).permit(:start_date, :end_date, :car_id)
  end
end
