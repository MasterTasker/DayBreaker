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

  attr_accessor :running_calculation

  after_initialize :set_defaults
  before_save      :touch_completed!

  def hours_til_due
    (due_at - Time.current.to_date)/1.hour
  end

  def estimated_hours_left
    estimated_hours - completed_hours
  end

  def priority
    estimated_hours_left / hours_til_due
  end

  def set_defaults
    self.due_at ||= Time.current + 1.day
  end

  def touch_completed!
    if completed_hours >= estimated_hours
      make_complete!
    else
      make_incomplete!
    end

    true # callbacks can't return false
  end

  def percent_complete
    (completed_hours / estimated_hours) * 100
  end

  def make_incomplete!
    self.completed           = false
    # self.completed_hours     = old_completed_hours
    # self.old_completed_hours = 0
    # self.completed_on        = nil
  end

  def make_complete!
    self.completed           = true
    # self.old_completed_hours = estimated_hours
    # self.estimated_hours     = completed_hours
    # self.completed_on        = Time.current.to_date
  end

end
