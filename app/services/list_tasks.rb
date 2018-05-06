class ListTasks < ListCollection

  attr_defaultable :task_respository, -> { Task }
  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize(params)
    @project_id = params.delete :project_id
    params = {page_size: 10}.merge params
    super params
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= task_respository.where project_id: @project_id
  end

end
