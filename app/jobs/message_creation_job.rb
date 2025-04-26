class MessageCreationJob
  include Sidekiq::Job

  def perform(app_token, chat_number, message_content, message_number)
    Rails.logger.info("MessageCreationJob started for token: #{app_token} and chat number: #{chat_number}")
    application = Application.find_by(token: app_token)
    if application.nil?
      Rails.logger.error("Application not found for token: #{app_token}")
      return
    end

    chat = application.chats.find_by(number: chat_number)
    if chat.nil?
      Rails.logger.error("Chat not found for token: #{app_token} and chat number: #{chat_number}")
      return
    end

    message = chat.messages.new(content: message_content, number: message_number)
    if message.save
      Rails.logger.info("Message created for token: #{app_token} and chat number: #{chat_number}")
    else
      Rails.logger.error("Message not created for token: #{app_token} and chat number: #{chat_number}")
    end
  end
end
