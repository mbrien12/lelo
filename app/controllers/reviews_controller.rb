class ReviewsController < ApplicationController
  before_action :set_review, only: [:show]

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @review = Review.new
  end

  def index
    @reviews = Review.all
  end

  def show
  end

  def create
    @review = Review.new(review_params)
    @review.skill_id = params[:skill_id]
    @review.student_id = current_user.id

    if @review.save
      redirect_to profile_path(current_user), notice: 'Review successfully submitted'

    else
      render 'profiles/show', id: current_user.id
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
