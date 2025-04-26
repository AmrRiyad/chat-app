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
        if params[:query].present?
          messages = Message.search(params[:query], @chat.id)
          formatted_messages = messages.map do |message|
            {
              matching_score: message._score,
              content: message.content,
              number: message.number
            }
          end
          render json: formatted_messages
        else
          render json: Message.where(chat_id: @chat.id)
        end
      end
    end
  end

  def create
    @application = Application.find_by(token: params[:application_token])
    if @application.nil?
      render json: { error: "Application not found" }, status: :not_found
    else
      @chat = Chat.find_by(number: params[:chat_number], application_id: @application.id)
      if @chat.nil?
        render json: { error: "Chat not found" }, status: :not_found
      else
        redis_key = "application:#{@application.token}:chat:#{@chat.number}:messages_count"
        if $redis.get(redis_key).nil?
          $redis.set(redis_key, @chat.messages_count, nx: true)
        end
        message_number = $redis.incr(redis_key)
        MessageCreationJob.perform_async(@application.token, @chat.number, message_params[:content], message_number)
        render json: { message: "Message created" }, status: :created
      end
    end
  end

  def show
    redis_key = "application:#{params[:application_token]}:chat:#{params[:chat_number]}:message:#{params[:number]}"
    cached_data = $redis.get(redis_key)

    if cached_data
      message_data = JSON.parse(cached_data)
      render json: { message: message_data, from_cache: true }
    else
      @application = Application.find_by(token: params[:application_token])
      if @application.nil?
        render json: { error: "Application not found" }, status: :not_found
      else
        @chat = Chat.find_by(number: params[:chat_number], application_id: @application.id)
        if @chat.nil?
          render json: { error: "Chat not found" }, status: :not_found
        else
          @message = Message.find_by(number: params[:number], chat_id: @chat.id)
          if @message.nil?
            render json: { error: "Message not found" }, status: :not_found
          else
            $redis.set(redis_key, @message.to_json, ex: 10)
            render json: { message: @message, from_cache: false }
          end
        end
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
