# frozen_string_literal: true

module Api
  class TasksController < BaseController
    before_action :set_task, only: %i[show]

    def index
      @pagy, @tasks = pagy(Task.all)

      json_response_with_serializer(@tasks)
    end

    def show
      json_response_with_serializer(@task)
    end

    private

    def set_task
      @task = Task.find(params[:id])
    end
  end
end
