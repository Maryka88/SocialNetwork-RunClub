class RoutesController < ApplicationController
  # controllo se l'utente è loggato
  before_filter :signed_in_user

  def index
    # prendo tutti gli itinerari del db - senza paginazione
    #@routes = Route.all
    # prendo tutti gli itinerari del db - con pagination
    @routes = Route.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
    # genero temporaneamente un nuovo itinerario
    #@route = Route.create(name: 'Percorso1', latitude: '41.891071', longitude: '12.633463', user_id: '1', difficulty: 'facile', latitude2: '41.944299', longitude2: '12.55998')
  end

  def create
  end

  def show
    # prendo la route con id :id
    @route = Route.find(params[:id])
  end

  def destroy
  end
end
