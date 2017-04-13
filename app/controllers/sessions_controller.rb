class SessionsController < ApplicationController
  def new
    if !!session[:user_id]
      redirect_to :profile
    end
  end

  def create
    if params[:user][:name].present? && params[:user][:password].present?
      @user = User.find_by( name: params[:user][:name] )
      if @user.try( :authenticate, params[:user][:password] )
        session[:user_id] = @user.id
        redirect_to :profile
      else
        redirect_to :login
      end
    else
      redirect_to :login
    end
  end

  def show
    unless !!current_user
      redirect_to :login
    else
      @user = current_user
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :login
  end
end
