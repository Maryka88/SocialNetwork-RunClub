class PostsController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  def create
    # creo nuovo post da info contenute in "new post" form
    @post = current_user.posts.build(params[:post])
    if @post.save
        flash[:success] = 'Post creato!'
        redirect_to root_url
    else
        render 'pages/home'
    end
  end

end
