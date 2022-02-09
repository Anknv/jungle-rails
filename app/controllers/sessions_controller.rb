class SessionsController < ApplicationController

  def new
  end
  def create
    user = User.find_by_email(params[:email])
     # the user exists & the password is correct.
    if user && user.authenticate(params[:password])
      # to save the user id inside the browser cookie.
      session[:user_id] = user.id
      redirect_to :root
    else
        # if login doesn't work, send back to the login form.
      redirect_to :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end


  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end