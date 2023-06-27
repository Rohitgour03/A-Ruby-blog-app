class CategoriesController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show] 

    def index
        @categories = Category.all
    end

    def show
        @category = Category.find(params[:id])
        @articles = @category.articles
    end
 
    def new 
        @category = Category.new
    end

     # POST /articles or /articles.json
    def create
        @category = Category.new(category_params)

        respond_to do |format|
        if @category.save
            format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
            format.json { render :show, status: :created, location: @category }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @category.errors, status: :unprocessable_entity }
        end
        end
    end

    private
        def category_params
            params.require(:category).permit(:title)
        end
end