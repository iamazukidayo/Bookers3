class UsersController < ApplicationController
  
  
  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
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
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end 
  
  
    
end
