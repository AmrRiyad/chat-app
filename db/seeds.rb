# Create Applications
applications = []
3.times do |i|
  applications << Application.create!(name: "Test Application #{i+1}")
end

# Create Chats
chats = []

applications.each_with_index do |app, app_index|
  3.times do |i|
    chat_name = "Test Chat #{app_index+1}#{i+1}"
    chats << Chat.create!(
      application_id: app.id,
      name: chat_name,
      number: i+1
    )
  end
end

# Create 2 messages for each chat
chats.each do |chat|
  2.times do |i|
    Message.create!(
      chat_id: chat.id,
      content: "Hello, world #{i+1}",
      number: i+1
    )
  end
end
