class Api::V1::ReviewsController < ApplicationController
  before_action :set_spot
  before_action :set_review, only: [:show, :update, :destroy]

  # GET /reviews
  def index
    @reviews = @spot.reviews.all

    render json: @reviews, exclude: 'spot'
  end

  # GET /reviews/1
  def show
    render json: @review
  end

  # POST /reviews
  def create
    @review = @spot.reviews.new(review_params)

    if @review.save
      render json: @review, exclude: 'spot', status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
  end

  private
    def set_spot
      @spot = Spot.find(params[:spot_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def review_params
      params.require(:review).permit(:name, :comment, :point)
    end
end
