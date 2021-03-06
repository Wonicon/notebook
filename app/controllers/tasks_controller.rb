require 'json'
require_relative 'common.rb'

class TasksController < ApplicationController
  before_action :set_active, only: [:index, :new, :show, :edit]

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
      insert_task_items(@task)
      redirect_to task_path(@task)
    else
      report_error(@task)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def destroy
    task = Task.find(params[:id])
    subject = task.subject
    task.destroy
    redirect_to subject_tasks_path(subject)
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :due_date)
  end

  def insert_task_items(task)
    task_items = params[:task][:items]
    return if task_items.empty?  # No data
    JSON.parse(task_items).each do |item_content|
      task_item = task.task_items.new(content: item_content)
      if !task_item.save
        report_error(task_item)
        break
      end
    end
  end

  private
  def set_active
    session[:current_controller] = 'Tasks'
  end
end
