require 'securerandom'
require 'data_uri'

class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
    @categories = Category.all
  end

  def create
    name = params[:subject][:name]
    cover = params[:subject][:cropped_cover]

    if not cover.empty?
      uri = URI::Data.new(cover)
      ext = uri.content_type.split('/').last
      url_path = File.join('/media', "#{SecureRandom.urlsafe_base64}.#{ext}")
      host_path = File.join(Rails.public_path, url_path)
      params[:subject][:cover] = url_path
    else
      params[:subject][:cover] = nil
    end

    @subject = Subject.new(subject_params)
    @subject.category = Category.find(params[:category])

    if @subject.save
      File.open(host_path, 'wb') { |f| f.write(uri.data) } if not cover.empty?
      redirect_to subject_path(@subject)
    else
      puts @subject.errors.full_messages
    end

  end

  def show
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    redirect_to subjects_path
  end

  private
  def subject_params
    puts params
    params.require(:subject).permit(:name, :description, :cover)
  end
end
