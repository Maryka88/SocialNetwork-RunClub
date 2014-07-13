class CommentRoutesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  def create
    # creo nuovo commento da info contenute in "new comment" form
    @comment_routes = current_user.comment_routes.build(params[:post])
    if @post.save
      flash[:success] = 'Commento creato!'
      redirect_to :back
    else
      session[:errors]=@post.errors.full_messages
      redirect_to :back
    end
  end

end
