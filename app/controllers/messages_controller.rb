class MessagesController < ApplicationController
  def index
    @application = Application.find_by(token: params[:application_token])
    if @application.nil?
      render json: { error: "Application not found" }, status: :not_found
    else
      @chat = Chat.find_by(number: params[:chat_number], application_id: @application.id)
      if @chat.nil?
        render json: { error: "Chat not found" }, status: :not_found
      else
        @messages = Message.where(chat_id: @chat.id)
        render json: @messages
      end
    end
  end

  def create
    @application = Application.find_by(token: params[:application_token])
    if @application.nil?
      render json: { error: "Application not found" }, status: :not_found
    else
      @chat = Chat.find_by(number: params[:number], application_id: @application.id)
      if @chat.nil?
        render json: { error: "Chat not found" }, status: :not_found
      else
        @message = @chat.messages.new(message_params)
        if @message.save
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def show
    @message = Message.find_by(number: params[:number], chat_id: params[:chat_number])
    if @message.nil?
      render json: { error: "Message not found" }, status: :not_found
    else
      render json: @message
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
