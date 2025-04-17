class Application < ApplicationRecord
  has_secure_token :token, length: 24

  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true
  validates :chats_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def as_json(options = {})
    super(options.merge(except: [ :id ]))
  end
end
