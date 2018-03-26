class LocationsController < ApplicationController
  def index
    @locations = Location.all
    respond_to do |format|
      format.html { render :index}
      format.js
    end
  end
  def new
    #@location = current_user.locations.new
    @location = Location.new
  end


  def create
    @user = current_user
    #@location = Location.create(location_params)
    @location = @user.locations.build(location_params)
    @user.save

    if @location.save
      respond_to do |format|
        format.js
        format.html {render :show}
      end
    end

  end

  def edit
    @location = Location.find(params[:id])
    respond_to do |format|
        format.js
    end
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
      respond_to do |format|
        format.json {render json: @location}
        format.html {render :show}
        format.js
      end

end

  def show

    @location = Location.find(params[:id])
#binding.pry
    respond_to do |format|
      format.json {render json: @location}
      format.js
      format.html {render :index}
    end

  end

  def destroy
    @location = Location.destroy(params[:id])
    respond_to do |format|
      format.html {render :root}
      format.js
    end
  end

  private

  def location_params
     params.require(:location).permit(:name,:description,:location,:img_url)
  end
end
