class UsersController < ApplicationController


  def index

  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You are now registered"
      session[:uid] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end



  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
