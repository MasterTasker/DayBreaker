class TasksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :allow_all_params!

  def index
    user_preferences = current_user.preferences
    days_to_show_at_once = user_preferences.delete(:days_to_show_at_once).to_i
    @future = days_in_the_future = params.fetch(:future, 0).to_i

    @tasks = current_user.incomplete_tasks
    @days  = Advancer.new(
      @tasks,
      user_preferences,
      days_in_the_future,
      days_to_show_at_once
    ).call

    @time_travel = (days_in_the_future > 1)
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.create!(
      params[:task].slice(
        :due_at,
        :name,
        :estimated_hours,
        :completed_hours
      )
    )
    redirect_to root_path
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.attributes = params[:task].slice(
      :due_at,
      :name,
      :estimated_hours,
      :completed_hours
    )
    @task.save!
    redirect_to root_path
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy!
    redirect_to root_path
  end

private

  def allow_all_params!
    params.permit!
  end

end
