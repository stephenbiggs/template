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


  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    flash[:success] = "Your account has been deleted"
    redirect_to root_path
  end



  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
