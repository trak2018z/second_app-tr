class SessionController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path #przekierowanie na stronę główn
    else
      flash.now[:danger] = 'Niepoprawne dane logowania'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def new
  end
end
