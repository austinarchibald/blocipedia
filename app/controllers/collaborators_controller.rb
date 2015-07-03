class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Collaborator Added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error adding collaborator. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end


  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator Removed."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing collaborator. Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end
end
