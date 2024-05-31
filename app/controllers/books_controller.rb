class BooksController < ApplicationController

  def new
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "投稿できたよ🐕"
    redirect_to books_path
    else
    @user = current_user
    @books = Book.all
    render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

 def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
 end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
