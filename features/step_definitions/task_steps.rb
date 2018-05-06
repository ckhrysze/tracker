Given(/^that project has (\d+) tasks$/) do |count|
  d.given_tasks project: @project, count: count
end

Given(/^that project has tasks:$/) do |table|
  tasks = d.given_tasks project: @project, data: table
end

Given(/^that project has a task "([^"]+)"$/) do |name|
  @task = d.given_task @project, attributes: {name: name}
end

When(/^I create a task with:$/) do |table|
  attributes = vertical_table table
  d.create_task attributes, @project.id
end

When(/^I request the project's tasks$/) do
  d.request_tasks @project
end

When(/^I request the task "([^"]+)"$/) do |task_id|
  d.request_task @project.id, task_id
end

When(/^I transition the task to "([\w-]+)"$/) do |status|
  begin
    d.transition_task @task, status: status
  rescue ActiveRecord::RecordInvalid => e
    d.errors << e.record.errors
  end
end

Then(/^the task has details:$/) do |table|
  ActiveCucumber.diff_one! @task, table
end

Then(/^I receive a text message$/) do
  last_message = FakeTwilioSMS.last_message
  expect(last_message[:body]).to eq("Task #{@task.name} complete!")
end

Then(/^the project has a task with:$/) do |table|
  ActiveCucumber.diff_all! Task.order(:created_at), table
end

Then(/^I get a status error$/) do
  d.verify_error :status
end
