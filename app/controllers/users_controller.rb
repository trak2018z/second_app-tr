class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Witaj w aplikacji Agregat!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil zaktualizowany pomyślnie..."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Proszę się zalogować"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
