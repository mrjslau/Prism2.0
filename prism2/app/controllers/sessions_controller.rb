class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = "You have logged in"
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Email/Password invalid'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
