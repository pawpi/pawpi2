class UsersController < ApplicationController
  
  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @result = @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        #log_in @user
        format.html { redirect_to @user, notice: "Please check your email to activate your account" }
        format.js  # rails redirects to /users/create.js.erb
      else
        format.html { 
          flash.now[:notice]="Save proccess coudn't be completed!" 
          render :new 
        }
        format.js  # rails redirects to /users/create.js.erb
      end
    end
  end
  
  def show
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end