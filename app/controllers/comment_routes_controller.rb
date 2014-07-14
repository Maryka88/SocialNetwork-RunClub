class CommentRoutesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  # controllo se utente segue
  #before_filter :correct_user, only: :create


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

  private

  # redirect a home se l'utente corrente non è quello "giusto"
  #def correct_user
    # inizializza l'oggetto @user (tolto da funz edit e update)
    #@user = User.find(params[:id])
    #redirect_to root_path unless current_user?(@user) # il met current_user?(user)è definito nel SessionsHelper
  #end

end
