class BooksController < ApplicationController
    
    before_action :authenticate_user!
    
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
        @user = current_user
        @book = Book.new
    end
    
    def show
        @book = Book.find(params[:id])
        @user = current_user
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
end
