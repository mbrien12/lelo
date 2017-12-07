require 'open-uri'
require 'json'

class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @skills = @user.skills # Skill.where(teacher: @user)
    @review = Review.new
    @message = Message.new

    if @user.role == 'teacher'
      @lessons = @skills.flat_map { |skill| skill.lessons }
    else
      @lessons = @user.lessons
    end


    skills = []
    lessons = @user.lessons
    lessons.each { |lesson| skills << lesson.skill }
    @unique_skills = skills.uniq

    @total_price = 0
    @lessons.each do |lesson|
      if lesson.status == "completed"
        @total_price += lesson.price
      end
    end


    # Meetup API call to get related topics and location for learners

    @lessons.each do |lesson|
      @lesson = lesson
    end


    if !@lesson.nil?
      @response = open(
      "https://api.meetup.com/find/groups?&sign=true&photo-host=public&lon=#{@lesson.skill.longitude}&text=#{@lesson.skill.name}&radius=5&lat=#{@lesson.skill.latitude}&page=6&key=#{ENV['MEETUP_KEY']}")
      @json = JSON.parse(@response.read)
    end

  end
end


