require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "validations" do
    subject { FactoryBot.build(:chat) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it "belongs to an application" do
      expect(subject.application).to be_present
    end
  end
end
