class WorldDriver
  include RSpec::Matchers

  attr_reader :errors, :results

  def initialize
    @results = nil
    @errors = []
  end

  def given_projects count: nil, data: nil
    if count.present?
      FactoryGirl.create_list :project, count.to_i
    elsif data.present?
      ActiveCucumber.create_many Project, data
    else
      fail 'No projects given'
    end
  end

  def given_project data: nil
    if data.present?
      ActiveCucumber.create_one Project, data
    else
      FactoryGirl.create :project
    end
  end

  def given_tasks project: nil, count: nil, data: nil
    if project.nil?
      fail 'No project given for given tasks'
    end

    if count.present?
      FactoryGirl.create_list :task, count.to_i, project: project
    elsif data.present?
      ActiveCucumber.create_many Task, data
    else
      fail 'No tasks given'
    end
  end

  def given_task project, data: nil, attributes: nil
    if attributes.present?
      FactoryGirl.create :task, attributes.merge({project: project})
    elsif data.present?
      ActiveCucumber.create_one Task, data, context: {project_id: project.id}
    else
      FactoryGirl.create :task, project: project
    end
  end

  def check_unexpected_errors
    errors.present? && fail("Unexpected errors happened:\n #{errors.join("\n")}")
  end

  def verify_error error_message
    begin
      error_included = errors.any? { |error| error.include? error_message }
      errors.delete_if { |error| error.include? error_message }
    rescue TypeError
      string_error = error_message.to_s
      error_included = errors.any? { |error| error.include? string_error }
      errors.delete_if { |error| error.include? string_error }
    end
    expect(error_included).to eq true
  end

end
