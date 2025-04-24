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
        $redis.incr("application:#{@application.token}:chats_count")
        $redis.set("application:#{@application.token}:chat:#{@chat.number}:messages_count", @chat.message_count, nx: true)
        render json: @chat, status: :created
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    redis_key = "application:#{params[:application_token]}:chat:#{params[:number]}"
    cached_data = $redis.get(redis_key)

    if cached_data
      chat_data = JSON.parse(cached_data)
      render json: { chat: chat_data, from_cache: true }
    else
      @application = Application.find_by(token: params[:application_token])
      if @application.nil?
        render json: { error: "Application not found" }, status: :not_found
      else
        @chat = Chat.find_by(number: params[:number], application_id: @application.id)
        if @chat.nil?
          render json: { error: "Chat not found" }, status: :not_found
        else
          $redis.set(redis_key, @chat.to_json, ex: 10)
          render json: { chat: @chat, from_cache: false }
        end
      end
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
