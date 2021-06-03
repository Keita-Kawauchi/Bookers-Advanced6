class BooksController < ApplicationController
before_action :authenticate_user!
  before_action :ensure_correct_book, only: [:edit, :destroy, :update,]

  def new
   @book=Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    @user=current_user
    if @book.save
      flash[:success] = "successfully created book!"
      redirect_to book_path(id: current_user)
    else
      @books=Book.all
      flash.now[:danger] = @book.errors
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
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
