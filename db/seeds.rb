# Create Applications
applications = []
3.times do |i|
  applications << Application.create!(name: "Test Application #{i+1}")
end

# Create Chats
chats = []
app_chat_counts = [ 2, 3, 4 ] # Number of chats for each application

applications.each_with_index do |app, app_index|
  chat_count = app_chat_counts[app_index]

  chat_count.times do |i|
    chat_name = "Test Chat #{app_index+1}#{i}"
    chats << Chat.create!(
      application_id: app.id,
      name: chat_name,
      number: i+1
    )
  end
end

# Create Messages
chat_message_counts = [ 2, 3, 2, 3, 2, 3, 2, 3, 2 ] # Messages per chat

chats.each_with_index do |chat, chat_index|
  message_count = chat_message_counts[chat_index]

  message_count.times do |i|
    Message.create!(
      chat_id: chat.id,
      content: "Hello, world #{i+1}",
      number: i+1
    )
  end
end
