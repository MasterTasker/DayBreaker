class TasksController < ApplicationController

  before_filter :authenticate_user!

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.create!(params.permit!)
  end

  def edit
    @task = current_user.tasks.find(params.permit![:id])
  end

  def update
    @task = current_user.tasks.find(params.permit![:id])
    @task.attributes = params.permit!
    @task.save!
  end

  def destroy
    @task.destroy!
  end

end
