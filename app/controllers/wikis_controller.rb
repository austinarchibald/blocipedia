class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    if @wiki.save
      redirect_to @wiki, notice: "Wiki created."

    else
      flash[:error] = "There was an error creating the wiki. Please try again."
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Wiki deleted."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
