class AuthorController < ApplicationController
  def new
  end

  def create
    puts params
    @author = Author.new(params.require(:author).permit(:first_name, :last_name, :homepage))
    @author.save
    redirect_to root_path, notice: 'Success!'
  end

  def show
    @author = Author.find(params[:id])
  end
end
