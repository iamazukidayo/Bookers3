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
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort_by { |book| -book.favorites.where(created_at: from...to).count }
    @book = Book.new
    @user = current_user
  end



  def show
    @book = Book.find(params[:id])
    read_count = ReadCount.new(book_id: @book.id, user_id: current_user.id)
    read_count.save
    current_user.read_counts.create(book_id: @book.id)
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


  def color
    @user = User.find(params[:user_id])
    @color = params[:color] # カラーに関するロジックも追加
    @books = Book.where(color: @color) # カラーに基づく検索結果
  end



  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id, :star)
  end
end
