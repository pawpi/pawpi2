class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      respond_to do |format|
          format.html { redirect_to @user, notice: "Save process completed!" }
          format.js  # rails redirects to /sessions/create.js.erb      end
      end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        respond_to do |format|
          format.html { redirect_to @user, notice: "Please Activate Account First!" }
          format.js  # rails redirects to /sessions/create.js.erb      end
        end
      end
    else
      respond_to do |format|
          format.html { render :new }
          format.js { flash.now[:notice]="Invalid email/password" }  # rails redirects to /sessions/create.js.erb
       end

    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end