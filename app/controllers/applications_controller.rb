class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
    render json: @applications
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redis_key = "application:#{@application.token}:chat_count"
      $redis.set(redis_key, @application.chat_count, nx: true)
      render json: @application, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def show
    redis_key = "application:#{params[:token]}"
    cached_data = $redis.get(redis_key)

    if cached_data
      application_data = JSON.parse(cached_data)
      render json: { application: application_data, from_cache: true }
    else
      @application = Application.find_by(token: params[:token])

      if @application
        $redis.set(redis_key, @application.to_json, ex: 10)

        render json: { application: @application, from_cache: false }
      else
        render json: { error: "Application not found" }, status: :not_found
      end
    end
  end

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
