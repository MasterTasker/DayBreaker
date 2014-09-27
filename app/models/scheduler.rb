class Scheduler
  def initialize(*tasks, opts = {})
  end

  # returns a hash of tasks for today's work day, greater than or equal to the
  # minimum possibl work for today
  def call
    times = {}
    min_work_day = task.total_min_work_day
    if min_work_day < max_work_day then
      min_work_day = max_work_day
    end

    tasks = tasks.sort {|a,b| b.daily_min <=> a.daily_min}
    tasks.each do |task|
      schedule[task] = schedule(task)
    end

    today(tasks, schedule, min_work_day)
  end

  private

  # given a task, assigns it a time
  def schedule(task)
    if task.daily_min < preferred_min then
      preferred_min
    elsif task.daily_min > preferred_min and task.daily_min < preferred_max then
      (preferred_min + preferred_max) / 2
    else
      daily_min
    end
  end

  # given a schedule of tasks and times, returns a schedule for today
  def today(tasks, schedule, time)
    sc = {}
    tasks = tasks.sort { |a,b| a.due_date <=> b.due_date }
    i = 0

    while sc.values.sum < time do
      sc[tasks[i]] = schedule[tasks[i]]
    end

    if sc.values.sum > time then
      overage = sc.values.sum - time
      sc[sc.values.last] -= overage
    end
    sc
  end
end
