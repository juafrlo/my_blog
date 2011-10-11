class SessionsController < ApplicationController
  def create
    if (RAILS_ENV != 'production' && params[:password] == APP_CONFIG['password']) || 
    (RAILS_ENV == 'production' && params[:password] ==  ENV['ADMIN_PASS'])
      flash[:notice] = t("controllers.sessions.successfully_logged_in")
      session[:admin] = true
      redirect_to home_url
    else
      flash.now[:error] = t("controllers.sessions.password_incorrect")
      render 'new'
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = t("controllers.sessions.successfully_logout")
    redirect_to home_url
  end
end