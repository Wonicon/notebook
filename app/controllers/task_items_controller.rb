require_relative 'common.rb'

class TaskItemsController < ApplicationController
  before_action :set_task_item, only: [:update, :delete]

  def create
    task = Task.find(params[:task_id])
    task_item = task.task_items.new(
      params.require(:task_item).permit(:content))
    if task_item.save
      redirect_to task
    else
      report_error(task_item);
    end
  end

  def update
    puts params[:finished]
    case params[:finished]
    when 'true'
      @task_item.update(finished_at: Date.today)
    when 'false'
      @task_item.update(finished_at: nil)
    end
    redirect_to @task_item.task
  end

  private
  def set_task_item
    @task_item = TaskItem.find(params[:id])
  end
end
