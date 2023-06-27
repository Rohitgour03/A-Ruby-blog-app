class TagsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]
     
    def index
        @tags = Tag.all
    end

    def show
        @tag = Tag.find(params[:id])
        @articles = @tag.articles
    end

    def new
        @tag = Tag.new
    end

    def create
        @tag = Tag.new(tag_params)

        respond_to do |format|
        if @tag.save
            format.html { redirect_to tag_url(@tag), notice: "Category was successfully created." }
            format.json { render :show, status: :created, location: @tag }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
        end
    end

    private 
        def tag_params
            params.require(:tag).permit(:title)
        end
end

