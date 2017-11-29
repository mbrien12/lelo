class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @skills = Skill.where(teacher: @user)
    @teacher_lessons = Lesson.where(teacher: @user)
    @student_lessons = Lesson.where(student: @user)
  end
end
