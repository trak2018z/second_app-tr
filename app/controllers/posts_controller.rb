class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def upvote
    @post = Post.find(params[:id])
    @point = Point.find_by(@post.id)
    @point.update(:amount => @point.amount.to_i + 1)
  end

  def downvote
    @post = Post.find(params[:id])
    @point = Point.find_by(@post.id)
    @point.update(:amount => @point.amount - 1)
  end

  def getPointAmount
    @point = Point.find_by(params[:id => current_user.id])
    if @point.nil?
      @point = 0
    end
  end

  def new
    if current_user
      @post = Post.new
    else
    redirect_to login_path
    end
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    if @post.save
      flash.now[:success] = "Dodano nowe znalezisko!"
      redirect_to posts_url
    else
      flash.now[:danger] = "Coś poszło nie tak, spróbuj ponownie."
      redirect_to posts_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def put_point
    params.require(:point).permit(:amount)
  end

end
