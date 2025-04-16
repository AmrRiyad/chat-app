class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy

  before_validation :assign_number, on: :create

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, uniqueness: true, numericality: true

  private

  def assign_number
    if number.blank?
      max_number = Chat.maximum(:number) || 0
      self.number = max_number + 1
    end
  end
end
