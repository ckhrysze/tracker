module V1
  class TasksController < ApplicationController
    swagger_controller :tasks, 'Tasks'

    swagger_api :index do
      summary 'List all tasks for the given project'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 10'
    end
    def index
      tasks, errors = ListTasks.new(index_params).call
      if errors.any?
        render json: { errors: errors }, status: 400
      else
        render json: tasks
      end
    end

    swagger_api :show do
      summary 'Fetch a single Task'
      param :path, :id, :string, :required, 'Task Id'
    end
    def show
      task = Task.find params[:id]
      if task.present?
        render json: TaskSerializer.new(task).attributes
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task'
      param :form, :name, :string, :required, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
    end
    def create
      project = Project.find params[:project_id]
      task = project.tasks.build(task_params)
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    swagger_api :update do
      summary 'Updates an existing Task'
      param :path, :id, :string, :required, 'Task Id'
      param :form, :name, :string, :optional, 'Task designation'
      param :form, :description, :string, :optional, 'Task description'
      param :form, :status, :string, :optional, 'Task status'
    end
    def update
      task = Task.find params[:id]
      if task.present? && task.update_attributes(task_params)
        render json: task
      elsif task.present?
        render json: { errors: task.errors.full_messages }, status: 400
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    private

    def index_params
      params.permit(:page, :page_size).to_h.symbolize_keys
    end

    def task_params
      params.require(:task).permit :name, :description, :status
    end
  end
end
