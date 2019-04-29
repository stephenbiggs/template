class UsersController < ApplicationController


  def index

  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
      # removed auto sign-in as now want user to confirm registration first
      # session[:uid] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Ooooppss, something went wrong!"
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


  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Your email has been confirmed.
      Please sign in to continue."
      redirect_to root_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_path
    end
  end



  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
