class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  before_validation :assign_number, on: :create

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, numericality: { only_integer: true }

  def as_json(options = {})
    super(options.merge(except: [ :id, :application_id ]))
  end

  private

  def assign_number
    if number.blank?
      max_number = Chat.where(application_id: application_id).maximum(:number) || 0
      self.number = max_number + 1
    end
  end
end
