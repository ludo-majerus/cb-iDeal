class SessionsController < ApplicationController

  def new
      session[:original_page_before_authentication] = request.referer
  end

  # POST /sessions/create
  def create
      user = User.find_by_email(params[:email]) 
      if user && user.authenticate(params[:password]) 
        session[:current_user_authenticated] = user.id

        # Verify admin right
        if user.admin 
          session[:current_user_admin] = user.admin
        end

        # Redirect the user o the previous page, before log in, if we have it in session
        if session[:original_page_before_authentication].nil? 
          urlteredirect = ideas_url
        else
          urlteredirect = session[:original_page_before_authentication]
          session[:original_page_before_authentication] = nil
        end

        redirect_to urlteredirect, notice: 'You are now logged in'
      else
        flash[:error] = 'Error during the authentication process'
        render 'new'
      end
  end

  # DELETE /sessions/delete
  def destroy
    session[:current_user_authenticated] = nil 
    session[:current_user_admin] = nil 
    redirect_to :back, notice: 'You are now logout.'
  end

end
 