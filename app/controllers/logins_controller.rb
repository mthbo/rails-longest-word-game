class LoginsController < ApplicationController

  def login
  end

  def create
    USERS.each do |user|
      if user[:username] == params[:username] && user[:password] == params[:password]
        session[:current_user_id] = user[:id]
        session[:scores] = []
        redirect_to root_path
      end
    end
  end

  def destroy
    @_current_user = session[:current_user_id] = nil
    redirect_to root_path
  end

end
