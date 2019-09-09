class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  #To prevent users messing with other users posts
  before_action :require_author, only: [:edit, :update, :destroy]


  def index
    #@articles = Article.all.order(:title)
    @articles = Article.all.order(created_at: :desc)
    #@articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
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

  def require_author
    redirect_to(@article) unless @article.user == current_user
  end


  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
