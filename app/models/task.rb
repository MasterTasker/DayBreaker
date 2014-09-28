class Task < ActiveRecord::Base
  self.primary_key = :id

  extend Canonical::UUID

  belongs_to :user

  default_scope do
    order :due_at
  end

  after_initialize :set_defaults

private

  def set_defaults
    self.due_at ||= Time.current
  end

end
