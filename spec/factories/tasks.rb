FactoryGirl.define do
  factory :task do
    association :project
    name
    description ''
  end
end
