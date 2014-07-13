class RoutesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  # controllo se l'utente può cancellare l'itinerario
  before_filter :correct_user, only: :destroy

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
      session[:errors]=@route.errors.full_messages
      redirect_to root_url
    end
  end

  def show
    # prendo la route con id :id
    @route = Route.find(params[:id])
  end

  def destroy
    @route.destroy
    redirect_to root_url
  end

  private

  def correct_user
    # l'utente ha un itinerario con l'id fornito?
    @route = current_user.routes.find_by_id(params[:id])
    # se no, redirect a homepage
    redirect_to root_url if @route.nil?
  end
end
