class ApiWorldDriver < WorldDriver
  include Rack::Test::Methods

  def initialize
    p 'Running Features in the API World'
    super
  end

  def app
    Rails.application
  end

  def request_list collection_path, params
    result = get "/v1/#{collection_path}?#{params.to_query}"
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end

  def request_tasks project
    request_list "projects/#{project.id}/tasks", {}
  end

  def request_task project_id, task_id
    result = get "/v1/projects/#{project_id}/tasks/#{task_id}"
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end

  def create_project attributes
    result = post '/v1/projects', { project: attributes }
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  def create_task attributes, project_id
    result = post "/v1/projects/#{project_id}/tasks", { task: attributes }
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  def transition_task task, status: nil
    fail "No staus given for task transition" if status.nil?

    result = put(
      "/v1/projects/#{task.project_id}/tasks/#{task.id}",
      { task: {status: status}}
    )
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    else
      task.status = status
    end
  end

end
