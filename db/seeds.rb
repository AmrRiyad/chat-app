# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

app1 = Application.find_or_create_by!(name: "Test Application 1")
app2 = Application.find_or_create_by!(name: "Test Application 2")
app3 = Application.find_or_create_by!(name: "Test Application 3")

chat1 = Chat.find_or_create_by!(application_id: app1.id, name: "Test Chat 10")
chat2 = Chat.find_or_create_by!(application_id: app1.id, name: "Test Chat 11")

chat3 = Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 20")
chat4 = Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 21")
chat5 = Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 22")

chat6 = Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 30")
chat7 = Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 31")
chat8 = Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 32")
chat9 = Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 33")

Message.find_or_create_by!(chat_id: chat1.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat1.id, content: "Hello, world 2")

Message.find_or_create_by!(chat_id: chat2.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat2.id, content: "Hello, world 2")
Message.find_or_create_by!(chat_id: chat2.id, content: "Hello, world 3")

Message.find_or_create_by!(chat_id: chat3.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat3.id, content: "Hello, world 2")

Message.find_or_create_by!(chat_id: chat4.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat4.id, content: "Hello, world 2")
Message.find_or_create_by!(chat_id: chat4.id, content: "Hello, world 3")

Message.find_or_create_by!(chat_id: chat5.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat5.id, content: "Hello, world 2")

Message.find_or_create_by!(chat_id: chat6.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat6.id, content: "Hello, world 2")
Message.find_or_create_by!(chat_id: chat6.id, content: "Hello, world 3")

Message.find_or_create_by!(chat_id: chat7.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat7.id, content: "Hello, world 2")

Message.find_or_create_by!(chat_id: chat8.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat8.id, content: "Hello, world 2")
Message.find_or_create_by!(chat_id: chat8.id, content: "Hello, world 3")

Message.find_or_create_by!(chat_id: chat9.id, content: "Hello, world 1")
Message.find_or_create_by!(chat_id: chat9.id, content: "Hello, world 2")
