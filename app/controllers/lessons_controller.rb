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
    @lesson.price = @lesson.skill.price

    @skill = @lesson.skill

    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @lesson.price_cents,
      description:  "Payment for lesson #{@lesson.name} - #{@lesson.id}",
      currency:     @lesson.price.currency,
      capture: false
    )
    @lesson.charge_id = charge.id


    if @lesson.save
      teacher = @skill.teacher
      if !teacher.phone.nil?
        client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
        message = client.messages.create from: ENV['TWILIO_NUMBER'], to: teacher.phone, body: "Hello from Lealo!\nYou received a new #{@lesson.name} lesson request from #{@lesson.student.name}!"
      end
      redirect_to profile_path(current_user), notice: "Your request has been sent"
    else
      p @lesson.errors.full_messages
      render 'skills/show'
    end
  end

  def update
   if params[:status] == "confirmed"
    charge = Stripe::Charge.retrieve(@lesson.charge_id)
    response = charge.capture

    if response.status == "succeeded"
      @lesson.paid = true
    end


     @lesson.status = "confirmed"
    elsif params[:status] == "completed"
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
