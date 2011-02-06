class SessionsController < ApplicationController
  before_filter :redirect_to_show_user_if_signed_in, :only => :new

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate( params[:session][:email],
                              params[:session][:password])

    if user.nil?
      flash.now[:error] = "Invalid email/password combination"
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

    def redirect_to_show_user_if_signed_in
      redirect_to user_path(current_user) if signed_in?
    end

end
