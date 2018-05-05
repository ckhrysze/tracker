# == Schema Information
#
# Table name: projects
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :integer          default(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name  (name) UNIQUE
#

class Project < ActiveRecord::Base
  has_many :tasks

  enum state: {
    disabled: -1,
    active: 10,
    archived: 20
  }

  validates :name, presence: true, uniqueness: true
  validates :state, presence: true

  after_initialize :set_default_state

  private

  def set_default_state
    self.state ||= :active
  end
end
