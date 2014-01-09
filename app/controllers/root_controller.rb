class RootController < ApplicationController
  def login
  end

  def logout
  end

  def index
  end

  def contact
  end

	def users_list
		if current_user.account_type == "admin"
			@client_list = User.all
		else
			redirect_to current_user
		end 
	end
end
