class SessionsController < ApplicationController
  def new
    redirect_to users_path_url(current_user) if logged_in?
  end

  def create
    admin_user = User.find_by(email: params.dig(:session, :email)&.downcase)
    
    if admin_user && admin_user.authenticate(params[:session][:password])
      log_in admin_user
      params[:session][:remember_me] == '1' ? remember(admin_user) : forget(admin_user)
      redirect_to users_path_url(admin_user.id)
    else
      flash.now['alert-danger'] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash['alert-success'] = "Successfully logged out"
    redirect_to root_url
  end
end
