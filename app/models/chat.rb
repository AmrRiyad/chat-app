class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :number, presence: true, numericality: { only_integer: true }

  def as_json(options = {})
    super(options.merge(except: [ :id, :application_id ]))
  end
end
