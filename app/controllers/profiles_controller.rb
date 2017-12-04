require 'open-uri'
require 'json'

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

    @lessons.each do |lesson|
      @lesson = lesson
    end

    # Meetup API call to get related topics and location for learners
    @key = "12422e59366e34213a1d2c1836652d19"

    @response = open("https://api.meetup.com/2/open_events?&sign=true&photo-host=public&lat=#{@lesson.skill.latitude}&text=#{@lesson.skill.name}&lon=#{@lesson.skill.longitude}&radius=5&page=20&key=#{@key}")
    @json = JSON.parse(@response.read)






  end
end


# latitude = lesson.skill.latitude
# longitude = lesson.skill.longitude
#  topic = lesson.skill.name
#  key = "12422e59366e34213a1d2c1836652d19"
#  response = open("https://api.meetup.com/2/open_events?&sign=true&photo-host=public&lat=#{latitude}&text=#{topic}&lon=#{longitude}&radius=5&page=20&key=#{key}")
#  json = JSON.parse(response.read)
#  return json
