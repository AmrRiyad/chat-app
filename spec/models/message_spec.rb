require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is invalid without a content" do
    subject { FactoryBot.build(:message, content: nil) }
    expect(subject).not_to be_valid
  end

  it "is invalid without a chat" do
    subject { FactoryBot.build(:message, chat_id: nil) }
    expect(subject).not_to be_valid
  end

  it "is invalid without a number" do
    subject { FactoryBot.build(:message, number: nil) }
    expect(subject).not_to be_valid
  end
end
