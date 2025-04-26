class ChatCreationJob
  include Sidekiq::Job

  def perform(app_token, chat_name, chat_number)
    Rails.logger.info("ChatCreationJob started for token: #{app_token} and number: #{chat_number}")

    application = Application.find_by(token: app_token)

    if application.nil?
      Rails.logger.error("Application not found for token: #{app_token}")
      return
    end

    chat = application.chats.new(name: chat_name, number: chat_number)

    if chat.save
      Rails.logger.info("Chat created for token: #{app_token} and number: #{chat_number}")
    else
      Rails.logger.error("Chat not created for token: #{app_token} and number: #{chat_number}")
    end
  end
end
