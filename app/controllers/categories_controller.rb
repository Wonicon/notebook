require_relative 'common.rb'

class CategoriesController < ApplicationController
  before_action :set_active, only: [:index, :new, :show, :edit]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
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
  end

  def edit
    @category = Category.find(params[:id])
    @edit = true
    render 'show'
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_active
    session[:current_controller] = 'Categories'
  end
end
