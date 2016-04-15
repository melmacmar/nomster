class PlacesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    # A bunch of other code here

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

def create
  @place = current_user.places.create(place_params)
  if @place.valid?
    redirect_to root_path
  else
    return render :new, status: :unprocessable_entity
  end

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

  def show
  @place = Place.find(params[:id])
  @comment = Comment.new
  end

  def photo
  @place = Place.find(params[:id])
  @comment = Comment.new
end

 def edit
  @place = Place.find(params[:id])
 end

def update
  @place = Place.find(params[:id])
  if @place.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end

  @place.update_attributes(place_params)
  redirect_to root_path
end

  @place.update_attributes(place_params)
  if @place.valid?
    redirect_to root_path
  else
    return render :edit, status: :unprocessable_entity
  end
end



def destroy
  @place = Place.find(params[:id])
  if @place.user != current_user
    return render text: 'Not Allowed', status: :forbidden
  end

  @place.destroy
  redirect_to root_path
end

  private

def place_params
    params.require(:place).permit(:name, :description, :address)
 end
end
