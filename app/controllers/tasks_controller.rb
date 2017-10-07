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
end
