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

  # def index
    # @books = Book.all
    # @book = Book.new
    # @user = current_user
  # end

  def index
    to = Time.current.at_end_of_day
    from = (to - 7.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    # @books = Book.all
    @book = Book.new
    @user = current_user
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
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
