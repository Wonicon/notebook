class TaskItemsController < ApplicationController
  before_action :set_task_item, only: [:update, :delete]

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
