When(/^I create a task with:$/) do |table|
  attributes = vertical_table table
  d.create_task attributes, @project.id
end

Then(/^the project has a task with:$/) do |table|
  ActiveCucumber.diff_all! Task.order(:created_at), table
end

