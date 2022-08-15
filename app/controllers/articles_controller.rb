class ArticlesController < ApplicationController
  def new
    @articles = Article.new
  end

  def index
    @articles = Article.all
  end

  def create
    article = Article.new(article_params)
    article.save
    redirect_to '/'
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end
end
