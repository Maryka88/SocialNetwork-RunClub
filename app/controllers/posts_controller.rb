class PostsController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  # controllo se l'utente può cancellare il post
  before_filter :correct_user, only: :destroy

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

  def destroy
    @post.destroy
    redirect_to current_user
  end

  private

  def correct_user
      # l'utente ha un post con l'id fornito?
      @post = current_user.posts.find_by_id(params[:id])
      # se no, redirect a homepage
      redirect_to root_url if @post.nil?
  end

end
