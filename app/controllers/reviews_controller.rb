class ReviewsController < ApplicationController
  def new
  @review =   review.new
  end

  def create

    @location = Location.find(params[:location_id])
    @review = @location.reviews.build(review_params)

    if @review.save
      respond_to do |format|
        format.json {render json: @review}
        format.html {render :show}
      end
    end

  end

  def show

    @review = Review.params([:id])
  end

  private
  def review_params
    params.require(:review).permit(:comment,:ratings,:location_id)
  end
end
