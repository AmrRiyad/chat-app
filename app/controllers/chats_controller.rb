class ChatsController < ApplicationController
  def index
    @application = Application.find_by(token: params[:application_token])
    if @application.nil?
      render json: { error: "Application not found" }, status: :not_found
    else
      @chats = @application.chats
      render json: @chats
    end
  end

  def create
    @application = Application.find_by(token: params[:application_token])
    if @application.nil?
      render json: { error: "Application not found" }, status: :not_found
    else
      @chat = @application.chats.new(chat_params)
      if @chat.save
        render json: @chat, status: :created
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    @chat = Chat.find_by(id: params[:id])
    if @chat.nil?
      render json: { error: "Chat not found" }, status: :not_found
    else
      render json: @chat
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
