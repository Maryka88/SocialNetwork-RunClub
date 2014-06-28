class UsersController < ApplicationController

  def show
    #prendo utente dall'id :id
    @user = User.find(params[:id])
  end

  def new
    #creo utente base per testing - poi da rimuovere
    @user = User.create(name: 'Marika', email: 'marika.pinori@polito.it', password: 'test0123', password_confirmation: 'test0123')
  end

end
