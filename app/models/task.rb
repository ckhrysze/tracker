# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  project_id  :uuid
#  status      :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Foreign Keys
#
#  fk_rails_02e851e3b7  (project_id => projects.id)
#

class Task < ActiveRecord::Base
  belongs_to :project

  enum status: {
    done: -1,
    todo: 10,
    in_progress: 20
  }

  validates :name, presence: true
  validates :status, presence: true

  after_initialize :set_default_status

  private

  def set_default_status
    self.status ||= :todo
  end

end
