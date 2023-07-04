class ArticlesController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]   
    before_action :set_article, only: %i[ show edit update destroy ]

    # GET /articles or /articles.json
    def index 
        @per_page = 3 
        @current_page = params[:page].present? ? params[:page].to_i : 1
        puts "Current page is now: #{@current_page}"
        offset = (@current_page - 1) * @per_page
        puts "offset is now: #{offset}"

        @articles = Article.limit(@per_page).offset(offset)
        @total_articles = Article.count

        if params[:sort_by] == 'title'
            @articles = @articles.order(title: :asc)
        elsif params[:sort_by] == 'published_date'
            @articles = @articles.order(created_at: :desc)
        elsif params[:search] 
            @articles = Article.where("title LIKE ?", "%#{params[:search]}%")
        end
    end

    # GET /articles/1 or /articles/1.json
    def show
        @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    # GET /articles/new
    def new
        @article = Article.new
    end

    # POST /articles or /articles.json
    def create
        @article = Article.new(article_params)

        respond_to do |format|
        if @article.save
            format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
            format.json { render :show, status: :created, location: @article }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
        end
        end
    end

    # GET /articles/1/edit
    def edit
    end

    # PATCH/PUT /articles/1 or /articles/1.json
    def update
        @article = Article.find(params[:id])
    
        respond_to do |format|
        if @article.update(article_params)
            format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
            format.json { render :show, status: :ok, location: @article }
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
        end
        end
    end 

    # DELETE /articles/1 or /articles/1.json
    def destroy
        @article = Article.find(params[:id])
        @article.comments.clear
        @article.destroy

        respond_to do |format|
        format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
        format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :author)
    end

end
