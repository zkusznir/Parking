class ParkingsController < ApplicationController
  before_action :parking, only: [:show, :edit, :update]
  skip_before_action :logged_in

  def index
    @parkings = Parking.search(params).paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @parking = Parking.new
    @parking.build_address
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to @parking
      flash[:success] = t(:create_success)
    else
      render action: 'new'
    end
  end

  def update
    if @parking.update(parking_params)
      redirect_to @parking
      flash[:success] = t(:update_success)
    else
      render action: 'edit'
    end
  end

  def destroy
    Parking.find(params[:id]).destroy
    flash[:success] = t(:delete_success)
    redirect_to parkings_url
  end

  private

  def parking
    begin
      @parking ||= Parking.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to parkings_path
      flash[:error] = t(:parking_not_found)
    end
  end

  def parking_params
    params.require(:parking).permit(:kind, :places, :hour_price, :day_price,
                                    address_attributes: [:city, :street, :zip_code])
  end

end