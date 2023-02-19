class Api::V1::SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :update, :destroy]

  # GET /spots
  def index
    @spots = Spot.includes(:reviews).with_attached_images
    @spots = @spots.order(price: params[:sort].to_sym) if params[:sort]

    render json: @spots, include: ['images', 'reviews']
  end

  # GET /spots/1
  def show
    render json: @spot, include: ['images', 'reviews']
  end

  # POST /spots
  def create
    @spot = Spot.new(spot_params)
    
    if @spot.save
      render json: @spot, status: :created
    else
      render json: @spot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /spots/1
  def update
    if params[:spot][:images]
      @spot.images.purge
    end

    if @spot.update(spot_params)
      render json: @spot
    else
      render json: @spot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /spots/1
  def destroy
    @spot.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def spot_params
      params.require(:spot).permit(:title, :description, :price, images: [])
    end
end
