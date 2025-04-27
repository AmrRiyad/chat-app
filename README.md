# Chat Application API

A robust Rails API for a real-time chat application with Elasticsearch integration for message search functionality. This application supports multiple chat applications, each with their own chats and messages.

## Features

- RESTful API design for managing chat applications, chats, and messages
- Real-time messaging capabilities with ActionCable
- Full-text search for messages using Elasticsearch
- Background job processing with Sidekiq and Redis
- MySQL database for persistent storage
- Containerized with Docker and Docker Compose for easy deployment
- Automated testing with RSpec and FactoryBot

## System Requirements

- Ruby 3.x
- Rails 8.0.2
- MySQL 8.x
- Redis
- Elasticsearch 7.x
- Docker and Docker Compose (for containerized setup)

## Installation

### Using Docker (Recommended)

1. Clone the repository:
   ```
   git clone https://github.com/AmrRiyad/chat-app.git
   cd chat-app
   ```

2. Create and configure your `.env` file (use the provided `.env.example` as a template)

3. Install dependencies:
   ```
   bundle install
   ```

4. Build and start the Docker containers:
   ```
   docker compose up --build
   ```


## API Documentation

### Applications

- `GET /applications` - List all applications
- `POST /applications` - Create a new application
- `GET /applications/:token` - Show an application
- `PUT /applications/:token` - Update an application
- `DELETE /applications/:token` - Delete an application

### Chats

- `GET /applications/:token/chats` - List all chats for an application
- `POST /applications/:token/chats` - Create a new chat
- `GET /applications/:token/chats/:number` - Show a chat
- `PUT /applications/:token/chats/:number` - Update a chat
- `DELETE /applications/:token/chats/:number` - Delete a chat

### Messages

- `GET /applications/:token/chats/:chat_number/messages` - List all messages in a chat
- `POST /applications/:token/chats/:chat_number/messages` - Create a new message
- `GET /applications/:token/chats/:chat_number/messages/:number` - Show a message
- `GET /applications/:token/chats/:chat_number/messages/search` - Search messages in a chat

## Testing

Run the test suite with:

```
docker compose exec rails bundle exec rspec spec
```

## Background Jobs

This application uses Sidekiq for background job processing. Jobs include:
- Indexing messages in Elasticsearch
- Processing message deliveries

