class LessonsController < ApplicationController
    before_action :set_lesson, only: [:show, :update]
  def index
  end

  def show
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.completed = false
    @lesson.paid = false
    @lesson.student_id = current_user.id


    @skill = @lesson.skill

    if @lesson.save
      redirect_to @skill, notice: 'Lesson was successfully requested '
    else
      render 'skills/show'
    end
  end

  def update
    # if params[:confirm] == 'true'
    #   @booking.confirm!
    # elsif params[:cancel] == 'true'
    #   @booking.cancel!
    # end

    # redirect_to profile_path(current_user)
  end


  private
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
      params.require(:lesson).permit(:date, :skill_id, :name, :price)
  end

end
