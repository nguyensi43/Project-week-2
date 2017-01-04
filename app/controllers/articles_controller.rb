class ArticlesController < ApplicationController
before_action :find_post, only: [:edit, :update, :show, :delete]
before_action :authenticate_user!, except: [:index, :show]
  def index
    if params[:category].blank?
      @articles = Article.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @articles = Article.where(:category_id => @category_id).order("created_at DESC")
    end
  end
 
  def show
    @article = Article.find(params[:id])
  end
 
  def new
    @article = current_user.articles.new
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end
 
  def edit
    @article = Article.find(params[:id])
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end
 
  def create
    @article = current_user.articles.new(article_params)
    @article.category_id = params[:category_id]
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
 
  def update
    @article.category_id = params[:category_id]
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
 
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  def find_post
   @article = Article.find(params[:id])
  end
  private
    def article_params
      params.require(:article).permit(:title, :text, :category_id)
    end  
end
