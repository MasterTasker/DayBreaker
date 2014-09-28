class DashboardController < ApplicationController
  def view
    @user = current_user
    today_sch = Scheduler.new(@user.tasks, {
      max_work_day: @user.max_work_day,
      min_work_period: @user.min_work_period,
      max_work_period: @user.max_work_period
    }
    @today = Scheduler.call

    tom_sch = Scheduler.new(@user.tasks, {
      max_work_day: @user.max_work_day,
      min_work_period: @user.min_work_period,
      max_work_period: @user.max_work_period
    }
    @tomorrow = Scheduler.call
  end
end
