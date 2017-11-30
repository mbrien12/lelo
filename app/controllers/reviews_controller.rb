class ReviewsController < ApplicationController
  before_action :set_review, only: [:show]

  def index
  end

  def show
  end

  def create
    @review = Review.new(review_params)
    @student = current_user.id

    if @review.save
      redirect to @student, notice: 'Review successfully submitted'
    else
      render 'profiles/id'
    end
  end


  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating, :skill_id)
  end
end
