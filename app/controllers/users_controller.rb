class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to edit_user_account_path(@user), :notice => "User updated."
      @user.set_wikis_public
    else
      redirect_to edit_user_account_path(@user), :alert => "Unable to update user."
    end
  end

  def edit
    @user = User.find(params[:id])
    render 'users/account/edit'
  end


  private

  def user_params
    params.require(:user).permit(:role)
  end


end
