class TaskCreator < ActiveCucumber::Creator

  def initialize(attributes, context)
    super
    @attributes["project_id"] = @project_id
  end
end
