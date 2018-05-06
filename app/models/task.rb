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
    'in-progress': 20
  }

  validates :name, presence: true
  validates :status, presence: true
  validate :ensure_proper_status_progression, on: :update

  after_initialize :set_default_status
  after_commit :on_task_complete, if: :is_task_now_complete

  private

  def set_default_status
    self.status ||= :todo
  end

  def ensure_proper_status_progression
    if self.status_changed?
      return true if self.status_changed?(from: 'todo', to: 'in-progress')
      return true if self.status_changed?(from: 'in-progress', to: 'todo')
      return true if self.status_changed?(from: 'in-progress', to: 'done')
      errors.add(:status, "Invalid status transition")
    end
  end

  def is_task_now_complete
    if self.previous_changes.member?('status')
      return true if self.previous_changes['status'] == ['in-progress', 'done']
    end
    return false
  end

  def on_task_complete
    Notifier.send_task_complete_notification(self)
  end

end
