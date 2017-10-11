require 'securerandom'
require 'data_uri'


class Cover
  attr_reader :url

  def initialize(data_url)
    @data_url = data_url
    if data_url and not data_url.empty?
      @uri = URI::Data.new(data_url)
      ext = @uri.content_type.split('/').last
      @url = File.join('/media', "#{SecureRandom.urlsafe_base64}.#{ext}")
      @filename = File.join(Rails.public_path, url)
    else
      @url = nil
    end
  end

  def save
    if @data_url and not @data_url.empty?
      File.open(@filename, 'wb') { |f| f.write(@uri.data) }
    end
  end
end


class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :destroy, :update]

  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
    @categories = Category.all
  end

  def create
    name = params[:subject][:name]
    cover = Cover.new(params[:subject][:cropped_cover])
    params[:subject][:cover] = cover.url if cover.url

    @subject = Category.find(params[:category])
                       .subjects
                       .new(subject_params)

    if @subject.save
      cover.save
      redirect_to subject_path(@subject)
    else
      puts @subject.errors.full_messages
    end
  end

  def show
  end

  def edit
    @categories = Category.all
    render 'new'
  end

  def update
    cover = Cover.new(params[:subject][:cropped_cover])
    params[:subject][:cover] = cover.url if cover.url
    if @subject.update(subject_params)
      cover.save
    end
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
    params.require(:subject).permit(:name, :description, :cover)
  end

  private
  def set_subject
    @subject = Subject.find(params[:id])
  end
end
