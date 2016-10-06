class UsersController < ApplicationController
before_action :logged_in

  def new
    render :new #signup?
  end

  def create #creates user
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login(@user)
      redirect_to user_url(@user) #is this different from :show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new #is this different from :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def logged_in
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
