# Maps controller
class MapsController < ApplicationController
  def index
    @maps = Map.all
  end

  def new; end

  def create
    map = Map.new(map_params)

    if map.save
      redirect_to '/maps'
    else
      flash[:errors] = @map.errors.full_messages
      redirect_to '/maps/new'
    end
  end

  def show
    @map = Map.find(params[:id])
    @people = Person.where(map_id: @map.id).all
  end

  private

  def map_params
    params.require(:map).permit(:city_name)
  end
end
