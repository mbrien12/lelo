class MessagesController < ApplicationController

  def index
    @messages = Message.where(sender: current_user).or(Message.where(receiver: current_user)).order(:created_at)
  end

  def new
    @message = Message.new
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:message_text, :receiver)
  end
end
