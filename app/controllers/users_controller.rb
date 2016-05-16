class UsersController < ApplicationController


  def login
    @user = User.find_by_email(params[:login][:email])
    if @user && @user.check_password(params[:login][:password_provided])
      session[:id] = @user.id
      redirect_to learning_path, notice: "you are logged in"
    else
      redirect_to root_path, notice: "Sorry. you could not be logged in."
    end
  end


  def new_user
    @user = User.new(params_of_user)
    if @user.save
      session[:id] = @user.id
      redirect_to learning_path, notice: "you have signed up."   
    else
      redirect_to learning_path, notice: "fail. you have not signed up."
    end
  end


  def logout
    session[:id] = nil
    redirect_to root_path, notice: "you are logged out."
  end


  private

  def params_of_user
    params.require(:new_user).permit(:email, :password_provided)
  end

  def params_of_login
    params.require(:login).permit(:email, :password)
  end

end