class RatingReviewsController < ApplicationController
	
	def index
   @ratings = RatingReview.all
  end

  # def show
  #   @reviews = @product.try(:rating_reviews).to_a
  #   @avg_rating = if @reviews.blank?
  #     0
  #   else
  #     @product.rating_reviews.average(:rating).round(2)
  #   end
  # end



	# def show
 #     @rating = RatingReview.find(params[:id])
 #  end

  def new
    @product = Product.find(params[:id])
    @rating = RatingReview.new
  end

  def edit
  end

  def create
    @product = Product.friendly.find(params[:rating_review][:product_id])
    @rating = RatingReview.new(rating_params)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @product, notice: 'RatingReview was successfully created.' }
        # format.html {redirect_back(fallback_location:  @reviews)}
        # format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'RatingReview  was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'RatingReview  was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @rating = RatingReview.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating_review).permit(:rating, :review, :product_id, :user_id)
    end
end
