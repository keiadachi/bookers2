class BooksController < ApplicationController

before_action :ensure_correct_user, only:[:edit]


  def new
   @user_image = User_image.new
   @book = Book.new
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
    @book = Book.find(params[:id])
    #@user = User.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:book] = "Book was successfully update."
      redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
     flash[:book] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

  def ensure_correct_user   #他の
    @book = Book.find(params[:id])
     unless @book.user == current_user
     redirect_to books_path
     end
  end

  def book_params
    params.require(:book).permit(:title, :body)
    #編集は1か所ずつだからbook単数形>
  end


end
