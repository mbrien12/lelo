class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def notify_lesson_request
    teacher = Skill.find(params[:skill_id]).teacher
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = client.messages.create from: ENV['TWILIO_NUMBER'], to: teacher.phone, body: 'Hello from Lealo!\nYou received a new lesson request!'
  end
end
