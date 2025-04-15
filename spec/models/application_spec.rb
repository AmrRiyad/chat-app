require 'rails_helper'

RSpec.describe Application, type: :model do
  subject { FactoryBot.build(:application) }  # assuming you have a FactoryBot factory

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it "requires chats_count to be present and non-negative" do
      subject.chats_count = nil
      expect(subject).not_to be_valid
      subject.chats_count = -1
      expect(subject).not_to be_valid
    end

    it "generates a secure token on creation" do
      subject.save!
      expect(subject.token).to be_present
      expect(subject.token.length).to eq(24)
    end
  end

  # If you need to test the increment functionality, you can indirectly test it through association callbacks or service objects
end
