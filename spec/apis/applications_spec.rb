require 'rails_helper'

RSpec.describe "Applications API", type: :request do
  describe "GET /applications" do
    before do
      get '/applications'
    end

    it "returns a list of applications" do
      expect(response).to have_http_status(:ok), "Status: #{response.status}, Body: #{response.body}"
      json_response = JSON.parse(response.body)
    end
  end

  describe "POST /applications" do
    before do
      # Skip CSRF verification for API requests in test environment
      ActionController::Base.allow_forgery_protection = false
    end

    after do
      # Re-enable CSRF protection after the test
      ActionController::Base.allow_forgery_protection = true
    end

    context "with valid parameters" do
      let(:valid_attributes) { { name: "My App" } }
      it "creates a new application" do
        post '/applications', params: { application: valid_attributes }
        expect(response).to have_http_status(:created), response.body
        json_response = JSON.parse(response.body)
        expect(json_response['name']).to eq(valid_attributes[:name])
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: "" } }
      it "does not create a new application" do
        post '/applications', params: { application: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
