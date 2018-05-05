class DomainWorldDriver < WorldDriver

  def initialize
    p 'Running Features in the Domain World'
    super
  end

  def request_list collection_type, params
    @results, e = "List#{collection_type.camelize}".constantize.new(params).call
    @errors.push *e
  end

  def create_project params
    project = Project.create params
    @errors.push *project.errors.full_messages
  end

  def create_task params, project_id
    project = Project.find project_id
    task = project.tasks.create params
    @errors.push *task.errors.full_messages
  end

end
