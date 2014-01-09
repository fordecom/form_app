class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

	def login_as_user
		if current_user.account_type == "admin"
			user = User.find(params[:user_id])
			sign_in(user)
			redirect_to user
		else
			redirect_to current_user
		end
	end

end

