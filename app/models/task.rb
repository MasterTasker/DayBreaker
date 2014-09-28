class Task < ActiveRecord::Base
  self.primary_key = :id

  extend Canonical::UUID

  belongs_to :user

  default_scope do
    order :due_at
  end

  class << self

    def complete
      where(completed: true)
    end

    def incomplete
      where(completed: false)
    end

  end

  after_initialize :set_defaults
  before_save      :touch_completeness!

  def hours_til_due
    (due_at - Time.current)/1.hour
  end

  def estimated_hours_left
    (estimated_hours - completed_hours)
  end

  def priority
    estimated_hours_left / hours_til_due
  end

  def set_defaults
    self.due_at ||= Time.current + 1.day
  end

  def touch_completeness!
    self.completed = (completed_hours >= estimated_hours)
    true # callbacks can't return false
  end

  def make_complete!
    self.estimated_hours = completed_hours
  end

end
