class CarsController < ApplicationController
  before_action :car, only: [:show, :edit, :update]

  def index
    @cars = current_person.cars
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.owner = current_person
    if @car.save
      redirect_to @car
      flash[:success] = 'Car successfully created!'
    else
      render action: 'new'
    end
  end

  def update
    @car.owner = current_person
    if @car.update(car_params)
      redirect_to @car
      flash[:success] = 'Car successfully updated!'
    else
      render action: 'edit'
    end
  end

  def destroy
    Car.find(params[:id]).destroy
    flash[:success] = 'Car successfully deleted!'
    redirect_to cars_url
  end

  private

  def car
    begin
      @car ||= current_person.cars.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to cars_path
      flash[:error] = 'No such car was found!'
    end
  end

  def car_params
    params.require(:car).permit(:registration_number, :model, :image, :remove_image)
  end
end
