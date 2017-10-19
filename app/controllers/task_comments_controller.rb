require_relative 'common.rb'

class TaskCommentsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    comment = task.task_comments
                  .new(params.require(:task_comment).permit(:content))
    if comment.save
      redirect_to comment.task
    else
      report_error(comment)
    end
  end
end
