class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    @result = @category.save
    respond_to do |format|
      if @result
        format.json do
          render json: {
            rendered: render_to_string(
              partial: 'categories/category',
              formats: :html,
              layout: false,
              locals: { category: @category }
            )}
        end
      else
        format.json { render json: {
          reason: @category.errors,
          name: params[:category][:name]
        }, status: :unprocessable_entity }
      end
    end
  end
end
