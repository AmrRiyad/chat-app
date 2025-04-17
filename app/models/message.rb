class Message < ApplicationRecord
  belongs_to :chat, counter_cache: true

  before_validation :assign_number, on: :create

  validates :content, presence: true
  validates :number, presence: true, numericality: { only_integer: true }

  def as_json(options = {})
    super(options.merge(except: [ :id, :chat_id ]))
  end

  private

  def assign_number
    if number.blank?
      max_number = Message.where(chat_id: chat_id).maximum(:number) || 0
      self.number = max_number + 1
    end
  end
end
