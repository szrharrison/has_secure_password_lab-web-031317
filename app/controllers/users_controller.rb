class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if passwords_match
      @user = User.new( user_params )
      @user.save
      session[:user_id] = @user.id
      redirect_to :profile
    else
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require( :user ).permit( :name, :password, :password_confirmation )
  end

  def passwords_match
    params[:user][:password] == params[:user][:password_confirmation]
  end
end
