class UsersController < ApplicationController
  include UsersHelper

  before_action :authenticate_user!, except: [:new, :create]
  before_action :new_user!, only: [:new, :create]
  before_action :active_user!, only: [:edit, :update, :edit_password, :update_password]
  before_action :track_user!, except: [:new, :create]
  before_action :authorize_user!

  def new
  end

  def create
    @user=User.new(user_all_params)

    if !UserInvite.exists?(params[:invite_code])
      flash.now[:danger]='Invite code is invalid'
      render 'new'
      return
    end

    if @user.save
      log_in(@user)
      remember(@user)
      save_user_create_event(user: @user)
      UserInvite.find_by(invite: params[:invite_code]).destroy
      flash[:success]="User created"
      redirect_to user_path(@user)
    else
      @errors=@user.errors.full_messages
      render 'new'
    end

  end

  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update

    @user=User.find(params[:id])
    @old=User.find(params[:id])

    if @user.update(user_info_params)
      save_user_edit_event(user_to: @user, user_from: @old, editor: current_user)
      flash[:success]="User updated"
      redirect_to user_path(@user)
    else
      @errors=@user.errors.full_messages
      render 'edit'
    end

  end

  def edit_password
    @user=User.find(current_user.id)
  end

  def update_password

    @user=User.find(current_user.id)
    @old=User.find(current_user.id)

    if @user.update(user_password_params)
      flash[:success]="Password updated"
      redirect_to user_path(@user)
    else
      @errors=@user.errors.full_messages
      render 'edit_password'
    end

  end

  def destroy
    user=User.find(params[:id])

    if user.active?
      flash[:success]="User deleted"
      save_user_delete_event(user: user, editor: current_user)
    else
      flash[:success]="User restored"
      save_user_restore_event(user: user, editor: current_user)
    end

    user.toggle!(:active)

    redirect_to root_path
  end

  def inactive
    @users=User.inactive
  end

  def index
    @users=User.active
  end

  private

  def user_all_params
    params.require(:user).permit(:identifier, :password, :password_confirmation, :name, :lastname)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_info_params
    params.require(:user).permit(:identifier, :name, :lastname)
  end

end
