class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(reviews_params)
    redirect_to '/restaurants'
  end

  private

  def reviews_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
