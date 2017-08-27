class Admin::UsersController < Admin::AdminBase
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    # add search
    if params[:q] && !params[:q].empty?
      @users = User.where('email LIKE ?', params[:q]).page(params[:page]).per(50)
    else
      @users = User.all.page(params[:page]).per(50)
    end


  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    #code
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if params[:user][:password].blank?
      @user.update_without_password(user_params)
    else
      @user.update_attributes(user_params)
    end
    if @user.errors.blank?
      redirect_to admin_users_path, :notice => "User updated successfully."
    else
      render :edit
   end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :admin)
    end
end
