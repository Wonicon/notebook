class PostsController < ApplicationController
  def index
    subject_id = params[:subject_id]
    if subject_id
      @subject = Subject.find(subject_id)
      @posts = @subject
    else
      @posts = Posts.all
    end
  end
end
