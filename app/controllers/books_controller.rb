class BooksController < ApplicationController
    
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
    
    def new
        @book = Book.new
        @user = current_user
    end
    
    def create
        @book = Book.new(book_params)
        @user = current_user
        @books = Book.all
        @book.user_id = current_user.id
        if @book.save
            redirect_to book_path(@book.id), notice: 'You have created book successfully.'
        else
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
        @book_comment = BookComment.new
        @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:id]) if user_signed_in?
    end
    
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end
    
    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to book_path(@book.id), notice: "Book was successfully updated."
        else
            render :edit
        end
    end
    
    private
    
    def book_params
        params.require(:book).permit(:title, :body)
    end
    
    def ensure_correct_user
        @book = Book.find(params[:id])
        unless @book.user == current_user
            redirect_to books_path
        end
    end
end
