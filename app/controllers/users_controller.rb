class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]
   before_action :before, only: [:show, :edit, :update, :followings, :followers, :correct_user]
  
  def before
    @user = User.find(params[:id])
  end
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
    @users = @microposts.page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
    
  def edit
  end
  
  def update
   
    if @user.update(user_params)
      flash[:success] = 'メッセージを編集しました'
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to user_path(@user)
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @users=  @user.following_users
  end
  
  def followers
    @users=  @user.follower_users
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation ,:location, :profile)
  end

  def correct_user
    redirect_to root_path if @user != current_user
  end
end
