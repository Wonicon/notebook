require 'securerandom'

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
    cover = params[:subject][:cover]
    ext = cover.content_type.split('/').last
    filename = File.join('media', "#{name}_cover.#{ext}")
    filepath = File.join(Rails.public_path, filename)
    params[:subject][:cover] = File.join('/', filename)
    @subject = Subject.new(subject_params)
    @subject.category = Category.find_by(id: params[:category])
    if @subject.save
      File.open(filepath, 'wb') { |f| f.write(cover.tempfile.read) }
      puts "save cover to #{filepath}"
      redirect_to subject_path(@subject)
    else
      puts @subject.errors.full_messages
    end
  end

  def show
    @subject = Subject.find(params[:id])
  end

  private
  def subject_params
    puts params
    params.require(:subject).permit(:name, :description, :cover)
  end
end
