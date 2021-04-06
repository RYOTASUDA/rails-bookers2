class BooksController < ApplicationController
    def new
        @book = Book.new
    end
    
    def create
        @book = Book.new(book_params)
        @user = current_user
        @books = Book.all
        @book.user_id = current_user.id
        if @book.save
            redirect_to book_path(@book)
        else
            render :index
        end
    end
    
    def index
        @books = Book.all
        @user = current_user
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
    
    private
    
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
