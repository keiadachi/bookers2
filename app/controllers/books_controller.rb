class BooksController < ApplicationController

  def new
   @user_image = User_image.new
   @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    #　↑確認
    if @book.save
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index #renderはコントローラーを通さない
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
   @books = Book.find(params[:id])
   @user = @books.user

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

  def book_params
    params.require(:book).permit(:title, :body)
    #編集は1か所ずつだからbook単数形>
  end

end
