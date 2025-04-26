class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

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
end
