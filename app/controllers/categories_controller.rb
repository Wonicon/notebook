require_relative 'common.rb'

class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    @result = @category.save
      if @result
        render json: render_to_string(
          partial: 'categories/category',
          formats: :html, layout: false,
          locals: { category: @category })
      else
        report_error(@category)
      end
  end

  def show
    @category = Category.find(params[:id])
    @subjects = @category.subjects
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
end
