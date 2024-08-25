class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    @user_reservations = current_user.reservations.where("start_time >= ?", DateTime.current).order(day: :desc)
    @visit_histroy = current_user.reservations.where("start_time < ?", DateTime.current).where("start_time > ?", DateTime.current << 12).order(day: :desc)  
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id then
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      if @is_room
      else
        @room = Room.new
        @entry = Entry.new
      end
    end

    @book_new = Book.new
    @books = @user.books
    @book = Book.find(params[:id])
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
    redirect_to user_path(@user.id)
   else
    render :edit
   end
  end

  def posts_on_date
    @user = User.includes(:books).find(params[:user_id])
    @date = Date.parse(params[:created_at])
    @books = @user.books.where(created_at: @date.all_day)
    render :posts_on_date_form
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end



end
