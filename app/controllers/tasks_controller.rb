require 'json'

class TasksController < ApplicationController
  def index
    subject_id = params[:subject_id]
    if subject_id
      @subject = Subject.find(subject_id)
      @tasks = @subject.tasks
    else
      @tasks = Task.all
    end
  end

  def new
    @subject = Subject.find(params[:subject_id])
  end

  def create
    @subject = Subject.find(params[:subject_id])
    submit_params = params[:task]
    due_date = submit_params[:due_date]
    task_items = submit_params[:items]

    @task = Task.new(task_params)
    @task.subject = @subject
    @task.due_date = Date.parse(due_date) if !due_date.empty?
    if @task.save
      if !task_items.empty?
        task_items = JSON.parse(task_items)
        task_items.each do |item_content|
          task_item = TaskItem.new
          task_item.content = item_content
          task_item.task = @task
          if !task_item.save
            render js: "alert(#{@task.errors.message})"
            break
          end
        end
        redirect_to subject_tasks_path(@subject)
      end
    else
      render js: "alert(#{@task.errors.message})"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
