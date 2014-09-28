class Task < ActiveRecord::Base
  self.primary_key = :id

  extend Canonical::UUID

  belongs_to :user

  default_scope do
    order :due_at
  end

  after_initialize :set_defaults

  def hours_til_due
    (due_at - Time.current)/1.hour
  end

  def estimated_hours_left
    (estimated_hours - completed_hours)
  end

  def priority
    estimated_hours_left / hours_til_due
  end

private

  def set_defaults
    self.due_at ||= Time.current + 1.day
  end

end
