# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

app1 = Application.create!(name: "Test Application 1")
app2 = Application.create!(name: "Test Application 2")
app3 = Application.create!(name: "Test Application 3")

chat1 = Chat.create!(application_id: app1.id, name: "Test Chat 10", number: 1)
chat2 = Chat.create!(application_id: app1.id, name: "Test Chat 11", number: 2)

chat3 = Chat.create!(application_id: app2.id, name: "Test Chat 20", number: 1)
chat4 = Chat.create!(application_id: app2.id, name: "Test Chat 21", number: 2)
chat5 = Chat.create!(application_id: app2.id, name: "Test Chat 22", number: 3)

chat6 = Chat.create!(application_id: app3.id, name: "Test Chat 30", number: 1)
chat7 = Chat.create!(application_id: app3.id, name: "Test Chat 31", number: 2)
chat8 = Chat.create!(application_id: app3.id, name: "Test Chat 32", number: 3)
chat9 = Chat.create!(application_id: app3.id, name: "Test Chat 33", number: 4)

Message.create!(chat_id: chat1.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat1.id, content: "Hello, world 2", number: 2)

Message.create!(chat_id: chat2.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat2.id, content: "Hello, world 2", number: 2)
Message.create!(chat_id: chat2.id, content: "Hello, world 3", number: 3)

Message.create!(chat_id: chat3.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat3.id, content: "Hello, world 2", number: 2)

Message.create!(chat_id: chat4.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat4.id, content: "Hello, world 2", number: 2)
Message.create!(chat_id: chat4.id, content: "Hello, world 3", number: 3)

Message.create!(chat_id: chat5.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat5.id, content: "Hello, world 2", number: 2)

Message.create!(chat_id: chat6.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat6.id, content: "Hello, world 2", number: 2)
Message.create!(chat_id: chat6.id, content: "Hello, world 3", number: 3)

Message.create!(chat_id: chat7.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat7.id, content: "Hello, world 2", number: 2)

Message.create!(chat_id: chat8.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat8.id, content: "Hello, world 2", number: 2)
Message.create!(chat_id: chat8.id, content: "Hello, world 3", number: 3)

Message.create!(chat_id: chat9.id, content: "Hello, world 1", number: 1)
Message.create!(chat_id: chat9.id, content: "Hello, world 2", number: 2)
