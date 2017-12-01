class MessagesController < ApplicationController

  def index
    messages = Message.where(sender_id: current_user).or(Message.where(receiver_id: current_user)).order(created_at: :desc)
    @grouped_messages = message_grouping(messages)
  end

  def new
    @message = Message.new
    @users = User.all
  end

  def create
    @users = User.all

    @message = Message.new(message_params)
    @message.sender = current_user
    if @message.save
      redirect_to messages_path
    else
      render :new
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:message_text, :receiver_id)
  end

  def message_grouping(messages)
    g_m = Hash.new([].freeze)
    messages.each do |message|
      if message.sender_id != current_user.id
        g_m[message.sender_id] += [message]
      else
        g_m[message.receiver_id] += [message]
      end
    end
    return g_m
  end
end
