class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

  before_validation :assign_number, on: :create

  validates :content, presence: true
  validates :number, presence: true, numericality: { only_integer: true }

  settings do
    mappings dynamic: "false" do
      indexes :chat_id, type: :keyword
      indexes :content, type: :text, analyzer: "english"
    end
  end

  def as_json(options = {})
    super(options.merge(except: [ :id ]))
  end

  def self.search(query, chat_id)
    response = Message.__elasticsearch__.search(
      {
        query: {
          bool: {
            must:  [ { match:  { content: query } } ],
            filter: [ { term:   { chat_id: chat_id } } ]
          }
        }
      }
    )
    response
  end

  private

  def assign_number
    if number.blank?
      max_number = Message.where(chat_id: chat_id).maximum(:number) || 0
      self.number = max_number + 1
    end
  end
end
