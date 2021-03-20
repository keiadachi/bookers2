class UsersController < ApplicationController

before_action :ensure_correct_user, only:[:edit]
#他人のユーザー情報編集画面に遷移できないのを設定する時にアクションを入れる

  def new
   @user = User.new
   @user_image = User_image.new
   # ここの記述は正しいか
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    #　↑確認
    if @book.save
      flash[:book] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index #renderはコントローラーを通さない
    end
    
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
    if @user.update(user_params)
      flash[:user] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render action: :edit
    #current_userで個人へ遷移
    end
  end

  private
  
  def ensure_correct_user
     @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path
     end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
