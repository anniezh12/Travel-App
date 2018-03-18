class LocationsController < ApplicationController
  def new
    @location = current_user.locations.new
  end

  def create
    @user = current_user
    #@location = Location.create(location_params)
    @location = @user.locations.build(location_params)
    @user.save

    if @location.save
      respond_to do |format|
        format.json {render json: @location}
        format.html {render :show}
      end
    end

  end

  def edit
  #  binding.pry
    @location = Location.find(params[:id].to_i)
    respond_to do |format|
      #format.json {render json: @location}
      format.html {render :layout =>false, :partial => '/locations/location_form'}
    end
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)

      respond_to do |format|
        format.json {render json: @location}
        format.html {render :index}
      end

end

  def show

    @location = Location.find(params[:id].to_i)
    
    respond_to do |format|
      format.json {render json: @location}
      format.html {render :index}
    end

  end

  private

  def location_params
     params.require(:location).permit(:name,:description,:location,:img_url)
  end
end
