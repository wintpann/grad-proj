class SessionsController < ApplicationController
  def new
  end

  def create
    @user=User.find_by(identifier: session_params[:identifier])

    if @user && @user.authenticate(session_params[:password])
      log_in(@user)
      remember(@user)
      flash[:success]="Welcome, #{@user.name} #{@user.lastname}"
      redirect_to root_path
    else
      flash[:danger]='Invalid login/password'
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:identifier, :password)
  end
end
