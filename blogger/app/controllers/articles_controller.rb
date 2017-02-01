class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :require_login, except: [ :index, :show ] 
  def index
    @articles = Article.all
    if params[:month].present?
      @month = params[:month][:month]
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
    @article.view_count
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.views = 0
    @article.save

    flash.notice = "Article #{@article.title} has been created"
    redirect_to article_path(@article)
  end


  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article #{@article.title} has been updated"

    redirect_to articles_path
  end

    def destroy
    Article.find(params[:id]).destroy

    flash.notice = "Article #{@article.title} has been destroyed"

    redirect_to articles_path
  end

  def most_popular
    @articles = Article.all
  end

end
