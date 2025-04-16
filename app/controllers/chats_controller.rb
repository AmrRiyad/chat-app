class ChatsController < ApplicationController
  def index
    @application = Application.find_by(token: params[:application_token])
    @chats = @application.chats
    render json: @chats
  end

  def create
    @application = Application.find_by(token: params[:application_token])
    @chat = @application.chats.new(chat_params)
    if @chat.save
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
