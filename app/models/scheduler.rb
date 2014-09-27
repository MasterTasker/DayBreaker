class Scheduler
  # takes an array of tasks,
  # returns 
  def initialize(tasks, opts={})
    # user's daily maximum work preference
    @max_work_day = opts.fetch(:max_work_day, 8)
    # user's minimum preferred task length
    @min_work_period = opts.fetch(:min_work_period, 2)
    # user's maximum preferred task length
    @max_work_period = opts.fetch(:max_work_period, 4)
    # pass in a task and some projected time spent on it, to get projected
    # tasks for tomorrow
    proj = opts.fetch(:projections, {})
    proj.each do |task, time|
      task.time_complete -= time
    end
    @tasks = tasks
  end

  # returns a hash of tasks for today's work day, greater than or equal to the
  # minimum possibl work for today
  def call
    schedule = {}
    work_day = tasks[i].total_min_work_day
    if @max_work_day < work_day then
      @max_work_day = work_day
    end

    tasks = @tasks.sort { |a,b| b.daily_min <=> a.daily_min }
    tasks.each do |task|
      schedule[task] = schedule(task)
    end

    today(tasks, schedule, @max_work_day)
  end

  # given a task, assigns it a time
  def schedule(task)
    work = task.daily_min
    if work < @min_work_period then
      @min_work_period
    elsif work > @min_work_period and work < @max_work_period then
      (@min_work_period + @max_work_period) / 2
    else
      work
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
