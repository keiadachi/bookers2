class UsersController < ApplicationController

  def new
   @user = User.new
   @user_image = User_image.new
   # ここの記述は正しいか
  end

  def create
    @user = User.new(user_params)  #追記
    @user_image = User_image.new(post_image_params)
    @user_image.user_id = current_user.id
    @user_image.save
    redirect_to edit_user_path
  end

  def index
    @users = User.all
    @user = current_user
    #@user = User.new　#追記
  end

  def show
   @user = User.find(params[:id])
   @books = @user.books 
   @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
    #current_userで個人へ遷移
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
