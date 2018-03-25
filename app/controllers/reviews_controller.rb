class ReviewsController < ApplicationController

  def index
    #binding.pry
    @location = Location.find(params[:location_id].to_i)
    @reviews = @location.reviews
#binding.pry

        render json: @reviews

        end

  def new
  @review =   review.new
  end

  def create
    @location = Location.find(params[:review][:location_id].to_i)
    @review = @location.reviews.build(review_params)
      @reviews = @location.reviews
    if @review.save
      respond_to do |format|
        format.json {render json: @reviews}
        format.html {render :show}
      end
    end

  end

  def show
    @review = Review.params([:id])
  end

  private
  def review_params
    params.require(:review).permit(:comment,:ratings)
  end
end
