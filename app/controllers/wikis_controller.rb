class WikisController < ApplicationController
  after_action :verify_policy_scoped, only: :index
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @collaborations = User.all - [current_user]
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      new_collaboration
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash.now[:alert] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborations = User.all - [@wiki.user]
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update(wiki_params)
      edit_collaboration
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def new_collaboration
    params[:wiki][:user_ids].each do |user_id|
      collaboration = Collaboration.new
      collaboration.user_id = user_id
      collaboration.wiki_id = Wiki.count
      collaboration.save
    end
  end

  def edit_collaboration
    Collaboration.where(wiki_id: @wiki).each do |collaboration|
      collaboration.destroy
    end
    params[:wiki][:user_ids].each do |user_id|
      collaboration = Collaboration.new
      collaboration.user_id = user_id
      collaboration.wiki_id = Wiki.count
      collaboration.save
    end
  end

end
