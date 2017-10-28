require_relative 'common.rb'
require 'securerandom'
require 'data_uri'


class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :destroy, :update]
  before_action :set_active, only: [:index, :new, :show, :edit]

  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
    @categories = Category.all
  end

  def create
    subject = Category.find(params[:category])
                       .subjects
                       .new(subject_params)
    subject.cover = params[:subject][:cover]
    subject.cover.crop(params[:subject])
    if subject.save
      redirect_to subject
    else
      report_error(subject)
    end
  end

  def show
    @current_subject_page_tab = session[:current_subject_page_tab] || 'posts'
  end

  def edit
    @categories = Category.all
    render 'new'
  end

  def update
    if params[:subject][:cover]
      @subject.cover = params[:subject][:cover]
      @subject.cover.crop(params[:subject])
    end
    @subject.update(subject_params)
    puts @subject.cover
    puts @subject.cover.path
    category = Category.find(params[:category])
    if category != @subject.category
      @subject.update(category: category)
    end
    redirect_to @subject
  end

  def destroy
    @subject.destroy
    redirect_to subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :description)
  end

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def set_active
    session[:current_controller] = 'Subjects'
  end
end
