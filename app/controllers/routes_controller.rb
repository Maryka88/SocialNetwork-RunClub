class RoutesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  def index
    # prendo tutti gli itinerari del db - senza paginazione
    #@routes = Route.all
    # prendo tutti gli itinerari del db - con pagination
    @routes = Route.paginate(page: params[:page]).order('created_at DESC')
  end

  def create
    # creo nuovo itinerario da info contenute nel form
    @route = current_user.routes.build(params[:route])
    if @route.save
      flash[:success] = 'Itinerario creato!'
      redirect_to root_url
    else
      render 'pages/home'
    end
  end

  def show
    # prendo la route con id :id
    @route = Route.find(params[:id])
  end

  def destroy
  end
end
