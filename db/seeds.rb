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

# Using globally unique numbers for each chat
Chat.find_or_create_by!(application_id: app1.id, name: "Test Chat 10")
Chat.find_or_create_by!(application_id: app1.id, name: "Test Chat 11")
Chat.find_or_create_by!(application_id: app1.id, name: "Test Chat 12")

Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 20")
Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 21")
Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 22")
Chat.find_or_create_by!(application_id: app2.id, name: "Test Chat 23")

Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 30")
Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 31")
Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 32")
Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 33")
Chat.find_or_create_by!(application_id: app3.id, name: "Test Chat 34")
