class BooksController < ApplicationController
before_action :authenticate_user!
  before_action :ensure_correct_book, only: [:edit, :destroy, :update]

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
   @books = Book.new
  end

  def update
   @book = Book.find(params[:id])
    @book.user = current_user
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "successfully delete book!"
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
