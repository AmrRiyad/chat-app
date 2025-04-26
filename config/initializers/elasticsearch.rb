Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV["ELASTICSEARCH_URL"] || "http://elasticsearch:9200",
  log: true
)
Rails.application.config.after_initialize do
  begin
    # Create Elasticsearch index for the Message model if it doesn't exist
    if !Message.__elasticsearch__.index_exists?
      Message.__elasticsearch__.create_index! force: true
      Rails.logger.info "Elasticsearch index for Message created successfully."

      # Import all existing messages into Elasticsearch
      Message.import(force: true)
      Rails.logger.info "Existing messages imported into Elasticsearch index."
    end
  rescue StandardError => e
    Rails.logger.error "Error setting up Elasticsearch: #{e.message}"
  end
end
