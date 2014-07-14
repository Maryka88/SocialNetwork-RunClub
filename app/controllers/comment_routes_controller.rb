class CommentRoutesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  # controllo se l'utente può creare il commento
  before_filter :correct_user2, only: :create

  # controllo se l'utente può cancellare il commento
  before_filter :correct_user, only: :destroy

  def create
    # creo nuovo commento da info contenute in "new comment" form
    @comment_route = current_user.comment_routes.build(params[:comment_route])
    #@comment_route = CommentRoute.new()
    #@comment_route.content = params[:@comment_route][:content]
    #@comment_route.user_id = params[:user_id]
    @comment_route.route_id = params[:route_id]

    if @comment_route.save
      flash[:success] = 'Commento creato!'
      redirect_to :back
    else
      session[:errors]=@comment_route.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment_route.destroy
    flash[:success] = 'Commento eliminato!'
    redirect_to :back
  end

  private

  def correct_user
    # l'utente ha un commento con l'id fornito?
    @comment_route = current_user.comment_routes.find_by_id(params[:id])

    if @comment_route.nil?
      @comment_route = CommentRoute.find_by_id(params[:id])
      @route = Route.find_by_id(@comment_route.route_id)

      # se no, redirect a homepage
      redirect_to :back if (current_user!=@route.user)
    end

  end

  def correct_user2

    @route = Route.find_by_id(params[:route_id])

    if (current_user!=@route.user)
      # se no, redirect a homepage
      redirect_to :back unless current_user.r_following?(@route)
    end

  end


end
