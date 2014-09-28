class Advancer

  attr_accessor :tasks, :user_preferences, :advance_by, :beginning_from

  def initialize(tasks, user_preferences = {}, beginning_from = 0, advance_by = 2)
    @tasks            = tasks
    @user_preferences = user_preferences
    @advance_by       = advance_by
    @beginning_from   = beginning_from
  end

  def call
    beginning_from.times do
      advance_by_a_day
    end

    (0...advance_by).collect do
      advance_by_a_day
    end
  end

# IMPLEMENTATION

  # Returns schedule for a day and advances tasks by a day for next iteration,
  #  pruning completed tasks.
  def advance_by_a_day
    scheduler = Scheduler.new(tasks, user_preferences)
    tasks_and_time = scheduler.call

    advanced_tasks = tasks_and_time.map do |task, time_to_advance|
      task.completed_hours += time_to_advance
      task.touch_completed!
      task
    end

    @tasks = advanced_tasks.reject do |task|
      task.completed?
    end

    tasks_and_time
  end

end
