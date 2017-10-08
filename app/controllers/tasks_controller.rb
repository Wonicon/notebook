require 'json'
require_relative 'common.rb'

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
    due_date = params[:task][:due_date]
    params[:task][:due_date] = !due_date.empty? ? Date.parse(due_date) : nil

    @task = @subject.tasks.new(task_params)

    if @task.save
      task_items = params[:task][:items]
      if !task_items.empty?
        JSON.parse(task_items).each do |item_content|
          task_item = @task.task_items.new(content: item_content)
          if !task_item.save
            report_error(task_item)
            break
          end
        end
        redirect_to task_path(@task)
      end
    else
      report_error(@task)
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
