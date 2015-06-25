class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      redirect_to @wiki, notice: "Wiki created."

    else
      flash[:error] = "There was an error creating the wiki. Please try again."
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:id])
    authorize @wiki
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
