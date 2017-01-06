class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
      respond_to do |format|
        if @article.comment.save
                format.html { redirect_to('/', :notice => 'Line item was successfully created') }
                format.js 
                format.json { render :show, status: :created, location: @comment }
            else
                format.html { render :new }
                format.json { render json: @line_item.errors, status: :unprocessable_entity }
            end
        format.js
      end
  end
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
