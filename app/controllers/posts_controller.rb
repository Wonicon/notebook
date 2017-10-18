require_relative 'common.rb'

class PostsController < ApplicationController
  def index
    subject_id = params[:subject_id]
    if subject_id
      @subject = Subject.find(subject_id)
      @posts = @subject.posts
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
    @subject = Subject.find(params[:subject_id])
  end

  def create
    @subject = Subject.find(params[:subject_id])
    @post = @subject.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      report_error(@post)
    end
  end

  def show
    @post = Post.find(params[:id])
    @subject = @post.subject
  end

  def edit
    @post = Post.find(params[:id])
    render 'edit'
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    post = Post.find(params[:id])
    subject = post.subject
    post.destroy
    redirect_to subject_path(subject)
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
