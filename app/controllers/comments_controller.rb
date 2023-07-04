class CommentsController < ApplicationController
    def index
        @article = Article.find(params[:article_id])
        @comment = @article.comments.all
    end

    def show
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
    end
    
    def new
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new
    end
    
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end

    def edit
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
    end

    def update
        respond_to do |format|
            if @comment.update(comment_params)
                format.html { redirect_to article_comments_path(@article), notice: "Comment was successfully updated." }
                format.json { render :show, status: :ok, location: @comment }
              else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy

        respond_to do |format|
            format.html { redirect_to article_path, notice: "The comment is successfully deleted."}
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:user, :content)
        end
end
