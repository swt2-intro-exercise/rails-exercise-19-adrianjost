class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :edit, :update, :destroy]

  # GET /papers
  def index
    @papers = Paper.all
  end

  # GET /papers/1
  def show
  end

  # GET /papers/new
  def new
    @paper = Paper.new
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  def create
    begin
      params = paper_params
      @paper = Paper.new(params)
      if @paper.save(params) and update_paper_authors
        redirect_to @paper, notice: 'Paper was successfully created.'
      else
        render :new
      end
    rescue ActionController::ParameterMissing
      render :new
    end
  end

  # PATCH/PUT /papers/1
  def update
    begin
      params = paper_params
      if @paper.update(params) and update_paper_authors
        redirect_to @paper, notice: 'Paper was successfully updated.'
      else
        render :edit
      end
    rescue ActionController::ParameterMissing
      render :edit
    end
  end

  # DELETE /papers/1
  def destroy
    @paper.destroy
    redirect_to papers_url, notice: 'Paper was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paper_params
      params.require(:paper).permit(:title, :venue, :year, author_ids: [])
    end

    #update author manually (only way I got it working)
    def update_paper_authors
      author_ids = paper_params["author_ids"]
        if author_ids
          #remove hidden field from array
          author_ids.shift
          authors = Author.find(author_ids)
          @paper.authors = authors
          return @paper.save
        end
        return true
    end
end