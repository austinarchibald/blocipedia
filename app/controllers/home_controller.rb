class HomeController < ApplicationController
  before_action :go_to_wikis

  def index
  end

  protected

  def go_to_wikis
    redirect_to "/wikis" if current_user
  end
end
