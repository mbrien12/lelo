class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @skills = @user.skills # Skill.where(teacher: @user)
    @review = Review.new

    if @user.role == 'teacher'
      @lessons = @skills.flat_map { |skill| skill.lessons }
    else
      @lessons = @user.lessons
    end
  end
end
