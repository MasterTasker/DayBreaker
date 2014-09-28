class Scheduler

  attr_accessor :tasks, :max_hours_per_day, :min_hours_per_task, :max_hours_per_task

  def initialize(tasks, opts={})
    @tasks              = tasks
    @max_hours_per_day  = opts.fetch(:max_hours_per_day,  8)
    @min_hours_per_task = opts.fetch(:min_hours_per_task, 1)
    @max_hours_per_task = opts.fetch(:max_hours_per_task, 4)
  end

  def call
    prioritized_tasks = prioritize(tasks)

    tasks_hash = {}
    time_left_today = max_hours_per_day

    prioritized_tasks.each do |task|
      raw_time = time_for_task(task)

      break if time_left_today < raw_time

      rounded_time = round_time_to_quarter_hour(raw_time)

      tasks_hash[task] = rounded_time
      time_left_today -= rounded_time
    end

    tasks_hash
  end

# IMPLEMENTATION

  def prioritize(tasks)
    tasks.sort do |task|
      task.priority
    end.reverse
  end

  def time_for_task(task)
    if task.estimated_hours_left < min_hours_per_task
      min_hours_per_task
    elsif task.estimated_hours_left >= max_hours_per_task
      max_hours_per_task
    else
      task.estimated_hours_left
    end
  end

  def round_time_to_quarter_hour(time)
    (time * 4).round / 4.0
  end

end
