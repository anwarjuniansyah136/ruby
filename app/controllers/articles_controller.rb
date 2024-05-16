class ArticlesController < ApplicationController
    before_action :set_user
    before_action :set_article, only: [:show, :update, :destroy]
  
    def index
      @articles = @user.articles
      render json: @articles
    end
  
    def show
      render json: @article
    end
  
    def create
      @article = @user.articles.build(article_params)
      if @article.save
        render json: @article, status: :created, location: [@user, @article]
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @article.destroy
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_article
      @article = @user.articles.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :body)
    end
  end
  