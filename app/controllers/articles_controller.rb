class ArticlesController < ApplicationController
  before_action :set_articles, only: [:edit,:destroy,:show,:update]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @articles= Article.all
  end
  def new
    @article = Article.new
  end
  def edit
    
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was Created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  def update
   
    if @article.update(article_params)
      flash[:success] = "Article was Updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end
  def show
    
  end
  def destroy
    @article.destroy
    flash[:danger] = "Article was Deleted"
    redirect_to articles_path
    
  end
  
  private
    def set_articles
      @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title ,:description)
    end
    def require_same_user

      if current_user != @article.user
      
      flash[:danger] = "You can only edit or delete your own articles"
      
      redirect_to root_path
      
      end
    end
end
