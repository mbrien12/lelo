class LessonsController < ApplicationController
    before_action :set_lesson, only: [:show, :update]
  def index
  end

  def show
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.status = "pending"
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
   if params[:status] == "confirmed"
     @lesson.status = "confirmed"
    elsif params[:status] == 'completed'
      @lesson.status = "completed"
    end
    @lesson.save
    redirect_to profile_path(current_user)
  end


  private
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def lesson_params
      params.require(:lesson).permit(:date, :skill_id, :name, :price)
  end

end
