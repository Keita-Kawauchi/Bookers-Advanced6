class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_params)
    @book_comment.book_id = @book.id
    @book_comment.user_id = current_user.id
    if @book_comment.save
     flash[:notice]="Book was successfully created"
     redirect_to book_path(@book.id)
    else
     render "books/show"
   end
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
		book_comment.destroy
    flash[:notice]="Comment was successfully destroyed."
    redirect_to book_path(params[:book_id])
  end

  private

  def book_params
    params.require(:book_comment).permit(:comment)
  end
end
