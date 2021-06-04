class BooksController < ApplicationController
before_action :authenticate_user!
  before_action :ensure_correct_book, only: [:edit, :destroy, :update,]

  def new
   @book=Book.new
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @book = Book.new
    @books = Book.all
    @book.user_id = current_user.id
  end

  def create
   @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
   @book = Book.find(params[:id])
    if @book.user.id != current_user.id
       redirect_to books_path
    end
  end

  def update
   @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:success] = "successfully delete book!"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_book
    book = Book.find(params[:id])
    if current_user.id != book.user_id
    redirect_to books_path
    end
  end
end
